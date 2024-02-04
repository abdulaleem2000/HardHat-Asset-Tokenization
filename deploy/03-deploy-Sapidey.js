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

  //   const args = [
  //     "0x03bbCAa3C2bA0B7CfC3f60d33812B075740F2FdE", //token address
  //     //user address
  //   ];

  //deploying contract
  const safeMoon = await deploy("SafeMoon", {
    from: deployer,
    log: true,
    // we need to wait if on a live network so we can verify properly
    waitConfirmations: network.config.blockConfirmations || 1,
  });

  if (process.env.ETHERSCAN_API_KEY) {
    console.log("hello kese ho welcome g");
    await verify(safeMoon.address);
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

module.exports.tags = ["all", "spidey"];
