require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();
require("hardhat-deploy");

/** @type import('hardhat/config').HardhatUserConfig */
const SEPOLIA_RPC_URL = process.env.SEPOLIA_RPC_URL;
const MUMBAI_RPC_URL = process.env.MUMBAI_RPC_URL;
const Private_KEY = process.env.PRIVATE_KEY;
const Private_KEY_USER = process.env.PRIVATE_KEY_USER;
const Etherscan_API_KEY = process.env.ETHERSCAN_API_KEY;
const POLYGON_SCAN_API_KEY = process.env.POLYGONSCAN_API_KEY;

module.exports = {
  defaultNetworks: "hardhat",

  networks: {
    sepolia: {
      url: SEPOLIA_RPC_URL,
      accounts: [Private_KEY],
      chainId: 11155111,
      blockConfirmations: 6,
    },
    mumbai: {
      url: MUMBAI_RPC_URL,
      accounts: [Private_KEY, Private_KEY_USER],
      allowUnlimitedContractSize: true,
      chainId: 80001,
      hardhat: {
        blockGasLimit: 100000000429720, // whatever you want here
      },
      // gas: 8000000, // Set the gas limit
      // gasPrice: 2100000,
      blockConfirmations: 6,
    },
    // localhost: {
    //   url: "http://127.0.0.1:8545/",
    //   chainId: 31337,
    // },
  },
  etherscan: {
    apiKey: {
      //polygonMumbai: POLYGON_SCAN_API_KEY,
      sepolia: Etherscan_API_KEY,
    },
  },
  solidity: {
    compilers: [
      { version: "0.8.20" },
      { version: "0.7.6" },
      { version: "0.6.12" },
    ],
  },
  namedAccounts: {
    //by default 0th account is deployer
    deployer: {
      default: 0,
    },
    user: {
      default: 1,
    },
  },

  settings: {
    optimizer: {
      enabled: true,
      runs: 5000,
      details: { yul: false },
    },
  },
};
