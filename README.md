This project contains two contract use cases.

## Bidding Contract

Its a game deployed on smart contract. Anyone can start the bidding by putting some Ether and specifying bidding time. Before the bidding ends, anyone can come and put some Ether on the contract. After the bidding ends, highest Bidder gets all the Ether and wins.

Higher chances gives you higher yield here!

## Birthday Contract
### Requirements:
V0:
1. I can login with my address, add my Birthday to the contract. 
2. Anyone can view my birthday, and send me ether gift.
3. Ether will be bestowed to my address only on the date of my birthday. 
4. Everyone will be able to see how much gift an address/person has received. 

V1:
1. I can add my Birthday and a "wish-list" on the blockchain.
2. Wishlist will contains all the things I want for my Birthday and how much will they cost.
3. Anyone can view my birthday and wish list. They can send their ether gift to as many things in my wish list as they want.
4. Once I receive my generous gift, sender can share their gift on any social media platform (along with transaction hash ;))

V2:
1. Add other events to the blockchain as well, like: wedding anniversary, product launch ceremony, etc. 
2. Show the complete event's page to the viewers. 
3. Create a time interval, where all the gift can be withdrawn from the contract.

V3:
1. Celebrate your event with all your friends in Metaverse! 
2. They will receive NFTs on sending gift, which will act as an entry token to the Metaverse world.

## Identity Management Contract

Moved to another package [here](https://github.com/mahima-manik/nft-certificates-dapp)

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

### References:
1. How to read event/transaction data emitted: https://trufflesuite.com/docs/truffle/reference/contract-abstractions#processing-transaction-results