const { network } = require("hardhat");

const { verify } = require("../utils/verify");

const axios = require("axios");

module.exports = async ({ getNamedAccounts, deployments }) => {
  const { deploy, log } = deployments;
  const { deployer } = await getNamedAccounts();

  const chainId = network.config.chainId;

  const args = ["bat coin", "bat", 10000];

  //deploying contract
  const createToken = await deploy("AssetNewToken", {
    from: deployer,
    args: args,
    log: true,
    // we need to wait if on a live network so we can verify properly
    waitConfirmations: network.config.blockConfirmations || 1,
  });

  if (process.env.POLYGONSCAN_API_KEY) {
    console.log("hello kese ho welcome g");
    await verify(createToken.address, args);
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

module.exports.tags = ["all", "createtoken"];
