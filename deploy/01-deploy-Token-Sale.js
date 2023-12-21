const { network } = require("hardhat");

const { verify } = require("../utils/verify");

const axios = require("axios");

module.exports = async ({ getNamedAccounts, deployments }) => {
  const { deploy, log } = deployments;
  const { deployer, user } = await getNamedAccounts();

  const chainId = network.config.chainId;

  // const senderAddress = "0xYourSenderAddress";
  // const receiverAddress = "0xYourReceiverAddress";
  // const privateKey = "0xYourPrivateKey";

  const args = [
    "0x5Ff135846589d6B492c1928541d0F0bD7FE68f27", //token address
    "0xd0D5e3DB44DE05E9F294BB0a3bEEaF030DE24Ada", //pricefeed address
    "0x9F5e972d10C79A86f9FC2C4DC2463cf2E411B536", //user address
  ];

  //deploying contract
  const assetToken = await deploy("AssetTokenSale", {
    from: deployer,
    args: args,
    log: true,
    // we need to wait if on a live network so we can verify properly
    waitConfirmations: network.config.blockConfirmations || 1,
  });

  if (process.env.POLYGONSCAN_API_KEY) {
    console.log("hello kese ho welcome g");
    await verify(assetToken.address, args);
    //     axios.post('https://api.polygonscan.com/api', postData)
    //     .then(response => {
    //       console.log('Response:', response.data);
    //     })
    //     .catch(error => {
    //       console.error('Error:', error);
    //     });
    //   }
  }
};

module.exports.tags = ["all", "tokensale"];
