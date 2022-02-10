# solidity-projects

Smart contract in Ethereum is a collection of code (its functions) and data (its state) that resides at a specific address on the Ethereum blockchain.

Following technologies are being used:

1. Solidity: Language for smae
2. Truffle: Framework for Ethereum smart contract development. Provides the compiler for smart contracts.
3. Ganache: Local Ethereum blockchain network with accounts and ether initialized.
4. Metamask wallet: It is a browser extension to store account keys. This Ether is used in deploying/interacting with the contract.
5. [Infura](https://infura.io/): Blockchain development suite, provides set of APIs to connect to Ethereum and IPFS network.
6. Rinkeby: Ethereum testnet. It uses Proof-of-authority.
7. Dotenv: For storing environmental variable constants and accessing them in config. Used to store private keys of wallets
8. Openzeppeline: Boiler plate smart contract code. ERC20 and ERC721 are golden standards for fungible and NFT tokens respectively. This library is most widely used and therefore tested by the industry.

Additionally install following packages in the project folder:

```
npm init
npm i @truffle/hdwallet-provider@2.0.0   #For connection between wallet and truffle
npm i doten # For loading environment variable (private keys and secret phase)
npm i @openzeppelin/contracts
npm i @openzeppelin/contracts --save
```

Commands used:

`truffle init`: To initialize an empty solidity project with just Migration contract.

`truffle compile`: Compiles solidity smart contract. JSON file is created in build/artifacts folder.

`truffle migrate`: Deploys the smart contract (present in `migrations/`) to the network specified in `truffle-config.js` 

Faucet sources:
1. https://faucets.chain.link/rinkeby: 0.1 Eth
2. https://rinkeby-faucet.com/: 0.01 Eth
