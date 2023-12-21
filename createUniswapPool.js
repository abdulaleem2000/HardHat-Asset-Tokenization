const { ethers } = require("ethers");
const axios = require("axios");
require("dotenv").config();

const UNISWAP_V3_FACTORY_ADDRESS = "0x1f98431c8ad98523631ae4a59f267346ea31f984";

const Network_Provider = new ethers.providers.JsonRpcProvider(
  process.env.MUMBAI_RPC_URL
);
const WALLET_ADDRESS = "0x7fD4f0C61B2aebb92B018C5B3D36c30981E7FA80";
const WALLET_SECRET_PHRASE = process.env.WALLET_SECRET_PHRASE;
const COIN_ADDRESS = "0xbEA9a95B3DE9d3E248Ed67A10d004cF78136B7f7";
