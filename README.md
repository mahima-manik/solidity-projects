This project contains two contract use cases.

## Identity Management Contract

Its a way for enterprises to release their NFT tokens easily and individuals to collect these tokens from various parties. Each NFT will serve as a certificate to the individual, as it can only be minted by the NFT creator directly.

Consider a use case: Each college or institute has its own token. This token is used to identify people belonging to this institute. Institute can mint their token to their members. Similarly, these members can collect NFTs from various institutes.


### Requirements
1. Authority should be able to add the certificate to the blockchain.
2. Only authority should be able to issue the certificate to individuals.
3. Issue certificate as NFT
4. Verify that the certificate is issued to the given address.

## Bidding Contract

Its a game deployed on smart contract. Anyone can start the bidding by putting some Ether and specifying bidding time. Before the bidding ends, anyone can come and put some Ether on the contract. After the bidding ends, highest Bidder gets all the Ether and wins.

Higher chances gives you higher yield here!

## Concepts

Smart contract in Ethereum is a collection of code (its functions) and data (its state) that resides at a specific address on the Ethereum blockchain.

Following technologies are being used:

1. Solidity: Language for writing smart contract
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
npm i dotenv # For loading environment variable (private keys and secret phase)
npm i @openzeppelin/contracts
npm i @openzeppelin/contracts --save
```

#### Commands used:

`truffle init`: To initialize an empty solidity project with just Migration contract.

`truffle compile`: Compiles solidity smart contract. JSON file is created in build/artifacts folder.

`truffle migrate`: Deploys the smart contract (present in `migrations/`) to the network specified in `truffle-config.js`

#### Faucet sources:
To get ether in Metamask wallet to deploy and interact with smart contracts on Rinkeby/Mumbai testnets
1. https://faucets.chain.link/rinkeby: 0.1 Eth
2. https://rinkeby-faucet.com/: 0.01 Eth