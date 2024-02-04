const { run } = require("hardhat");
const axios = require("axios");
const verify = async (contractAddress) => {
  console.log("Verifying contract...");
  console.log(await contractAddress);
  try {
    //axios.all
    await run("verify:verify", {
      address: contractAddress,
      //constructorArguments: args,
    });
  } catch (e) {
    if (e.message.toLowerCase().includes("already verified")) {
      console.log("Already Verified!");
    } else {
      console.log(e);
    }
  }
};

module.exports = { verify };
