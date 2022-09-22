// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "./IUniswapV2Router02.sol";
import "./IERC20.sol";

contract LiftInvest {
    uint256[] allocation;
    address[] tokens;
    address[][] paths;
    mapping(address => mapping(address => uint256)) shares; // Token address -> user address -> shares

    event LOG_DEPOSIT(address indexed user_id, uint256 amount_in);

    event LOG_WITHDRAW(
        address indexed user_id,
        uint256 percentage,
        uint256 amount_out
    );

    event Received(address sender, uint256 amount);

    receive() external payable {
        emit Received(msg.sender, msg.value);
    }


    IUniswapV2Router02 uniswap_router =
        IUniswapV2Router02(0xa5E0829CaCEd8fFDD4De3c43696c57F7D7A678ff);

    constructor(
        uint256[] memory _allocation,
        address[] memory _tokens,
        address[][] memory _paths
    ) payable {
        require(_allocation.length == _tokens.length);
        require(_tokens.length == _paths.length);

        allocation = _allocation;
        tokens = _tokens;
        paths = _paths;
    }

    function deposit() external payable {
        uint256[] memory amounts = new uint256[](tokens.length);

        uint256 quota_price = 0;
        for (uint8 i = 0; i < allocation.length; i++) {
            amounts[i] = uniswap_router.getAmountsIn(allocation[i], paths[i])[
                0
            ];
            quota_price += amounts[i];
        }

        uint256 n_quotas = msg.value / quota_price;

        for (uint8 i = 0; i < tokens.length; i++) {
            address _token = tokens[i];
            uint256 _amount = amounts[i] * n_quotas;
            address[] memory path = paths[i];
            uint256[] memory result = uniswap_router.swapExactETHForTokens{value: _amount}(
                1, // amountOutMin TODO use oracle
                path, // path
                address(this), // to
                block.timestamp + 100000 // deadline
            );

            uint256 bought = result[result.length - 1];

            shares[_token][msg.sender] += bought;
        }

        emit LOG_DEPOSIT(msg.sender, msg.value);
    }

    function withdraw(
        uint256 _sell_pct
    ) external {
        require(_sell_pct > 0, "SELL PCT NEEDS TO BE GREATER THAN ZERO");
        require(
            shares[tokens[0]][msg.sender] > 0,
            "NEEDS TO HAVE SHARES OF THE INDEX"
        );
        require(_sell_pct <= 100, "CAN'T SELL MORE THAN 100% OF FUNDS");

        uint256 eth_amount = 0;

        for (uint256 i = 0; i < tokens.length; i++) {
            address _token = tokens[i];
            uint256 shares_amount = (shares[_token][
                msg.sender
            ] * _sell_pct) / 100;

            address[] memory path = new address[](paths[i].length);
            for (uint j = 0; j < paths[i].length; j++) {
                path[j] = paths[i][paths[i].length - j - 1];
            }

            require(
                IERC20(_token).approve(
                    address(uniswap_router),
                    shares_amount
                ),
                "approve failed."
            );

            uint256[] memory result = uniswap_router.swapExactTokensForETH(
                shares_amount,
                1, // amountOutMin TODO use oracle
                path, // path
                address(this), // to
                block.timestamp + 100000 // deadline
            );

            shares[_token][msg.sender] -= result[0];
            eth_amount += result[result.length - 1];
        }
        payable(msg.sender).transfer(eth_amount);
        emit LOG_WITHDRAW(msg.sender, _sell_pct, eth_amount);
    }
}
