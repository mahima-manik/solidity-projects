# solidity-projects

Smart contract in Ethereum is a collection of code (its functions) and data (its state) that resides at a specific address on the Ethereum blockchain.

Following technologies are being used:

1. Solidity: Language for smae
2. Truffle: Framework for Ethereum smart contract development. Provides the compiler for smart contracts.
3. Ganache: Local Ethereum blockchain network with accounts and ether initialized.
4. Metamask wallet: To store account keys. This Ether is used in deploying/interacting with the contract.
5. Infura: Blockchain development suite, provides access to Ethereum network.
6. Rinkeby: Ethereum testnet. It uses Proof-of-authority.

Additionally install following packages in the project folder:

```
npm i @truffle/hdwallet-provider@2.0.0   #For connection between wallet and truffle
npm i doten # For loading environment variable (private keys and secret phase)
```

Commands used:

`truffle init`: To initialize an empty solidity project with just Migration contract.

`truffle compile`: Compiles solidity smart contract. JSON file is created in build/artifacts folder.

`truffle migrate`: Deploys the smart contract (present in `migrations/`) to the network specified in `truffle-config.js` 

