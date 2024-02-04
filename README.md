# Asset Tokenization

This project is used to store create contract that mint tokens containing property details. And user can buy those tokens. The contracts are deployed on polygon mumbai testnet.

## Getting Started
1. Clone the repository.
2. Install dependencies.
3. Set up any necessary configurations.

## Installation

Type this command in terminal to install dependencies:

```bash
npm install
```
After installation add following environment variables:
1. privatekey
2. etherscan api key
3. rpc url
4. polygonscan api key

## Compile
Type this command to compile all contracts:
```bash
npx hardhat compile
```

## deploy
Type this command to deploy contract on 
```bash
npx hardhat deploy --network numbai --tags createToken
```
