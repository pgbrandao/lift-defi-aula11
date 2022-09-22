---
title: Foobar
separator: <!--s-->
verticalSeparator: <!--v-->
theme: night
revealOptions:
  transition: "fade"
---

### Índices

##### ou _Gestão de Ativos_

Pedro Brandão<br />
Co-Founder @ [DeFi Basket](https://defibasket.org)

Twitter: [@pgbrandao](https://twitter.com/pgbrandao)<br />
GitHub: [@pgbrandao](https://github.com/pgbrandao)

_LIFT Learning – set/2022_

<!--s-->

## Intro

<!--s-->

## TradFi

<!--v-->

### Retorno por classe de ativo

![](media/2022-09-18-11-08-14.png)

https://novelinvestor.com/asset-class-returns/

<!--v-->

### Conceitos de TradFi

<ul>
<li class="fragment">Indexação</li>
<li class="fragment">Fundos de índice</li>
<li class="fragment">ETFs</li>
<li class="fragment">Gestão ativa vs gestão passiva</li>
</ul>

Note:
fundos de índice acompanham a precificação definida majoritariamente pela gestão ativa
é a gestão ativa quem define os preços
os preços determinam market cap
e o market cap é seguido pelos fundos de índice

como os fundos de gestão ativa são muito mais caros,
a longo prazo os fundos de gestão passiva tendem a performar melhor por serem muito mais baratos

<!--v-->

### S&P 500

Notes:
500 maiores empresas na NYSE e Nasdaq

Regras complexas para entrar no S&P
Exemplo
Pra entrar no índice:

- 4 trimestres com balanços positivos
- Necessita aprovação de um comitê
  Resultado: Tesla demorou 10 anos

<!--v-->

### Crescimento dos ETFs

![](media/2022-09-22-04-08-54.png)

https://www.investopedia.com/the-future-of-etfs-4772514

<!-- ### Title -->

<!-- - História dos ETFs no mercado tradicional -->

<!-- - Gestão ativa vs gestão passiva
- Rebalanceamento
- Crescimento dos ETFs
- Algo que mostre que é difícil beat the market??
- Taxa de administração/performance
- ETFs vs fundos tradicionais -->

<!-- Note:

- ETFs → são produtos estruturados? -->

<!--v-->

John Bogle

<img src="./media/Jack_Bogle.jpg" alt="John Bogle" style="width:500px;"/><br />

<img src="./media/vanguard-logo.png" alt="John Bogle" style="width:200px;"/>

<!--v-->

### ETFs

_Exchange Traded Funds_: fundos negociados como ações. Alguns são de gestão ativa, mas a maioria é passiva.

Baratos: fundo de gestão passiva pode custar 0,03%.

<!--v-->

### Rebalanceamento

https://www.justetf.com/en/academy/what-is-portfolio-rebalancing.html

<!--s-->

### Uniswap

https://github.com/Uniswap/v3-core/blob/main/contracts/UniswapV3Pool.sol

### Simular transações tenderly

<!--s-->

<!-- ### DeFi Llama -->

<img src="media/2022-09-18-09-37-32.png" alt="" style="width:200px;"/>

https://defillama.com/protocols/Indexes

<!--s-->

### Lending

- Pq lending?
- Lending off-chain vs on-chain

<!--v-->

### Atores

- Lender
- Borrower
- Liquidador
- Oracle

<!--s-->

### AMM

- AMMs ~ fundos de investimento!

https://app.balancer.fi/#/pool/0xa33e376932b2c01323f0a7f9bbe0a53f7662b2e900010000000000000000031d

Ponderações

- Alocação: dinâmica da pool fará com que percentual se aproxime de valor percentual fixo
  - Valorização de moonshots tende a se encurtar
- Impernanent loss

<!--s-->

### DeFi Pulse Index

https://indexcoop.com/defi-pulse-index-dpi

<!--s-->

### TokenSets

<!--s-->

## Hands-on ✍️

VSCode

- [Prettier](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode)
- [JuanBlanco.solidity](https://marketplace.visualstudio.com/items?itemName=JuanBlanco.solidity)
- [Hardhat](https://marketplace.visualstudio.com/items?itemName=NomicFoundation.hardhat-solidity)

<!--v-->

```bash
npm install hardhat
npx hardhat
npm install @openzeppelin/contracts @uniswap/v2-core @uniswap/v2-periphery
```

```
contract LiftInvest {
  function createFund(
    uint256[] allocation,
    address[] token
  );
  function deposit payable();
  function withdraw();
}
```

<!--v-->

##### Descobrindo o path do quickswap

```bash
npm install ethers
node
```

```node
const ethers = await require("ethers");
const data = "0x..."; // tx data from metamask
ethers.utils.defaultAbiCoder.decode(
  ["uint256", "address[]", "address", "uint256"],
  ethers.utils.hexDataSlice(data, 4)
);
```

<!--v-->

##### Deploy

- Configurar rede

```bash
npx hardhat compile
npx hardhat run scripts/deploy.js --network polygon
```

<!--s-->

### What next?

- Implementar tokens ERC-20 que representem a alocação
- Implementar integração com depósitos na Aave
- Adicionar `require`s
- Permitir `paths` dinâmicos, permitindo otimização das rotas

<!--s-->

### DeFi Basket

- Batch de transações para criar um portfolio
- Ativos 100% _non-custodial_

<!--v-->

### Integrações possíveis

- Tokens ERC-20 (_buy and hold_)
- Lending de tokens (_receber yield_)
- LP tokens (_fornecer liquidez_)
- ...

<!--v-->

![](media/2022-09-18-11-46-20.png)

https://docs.defibasket.org/

<!--s-->

##### EIP-4987: Held token standard

https://eips.ethereum.org/EIPS/eip-4987

https://ethereum-magicians.org/t/eip-4987-held-token-standard-nfts-defi/7117/8
