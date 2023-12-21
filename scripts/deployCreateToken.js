const { ethers } = require("hardhat");
const { verify } = require("../utils/verify");

async function main() {
  const [deployer] = await ethers.getSigners();
  const args = ["AbdulCoin", "ABC", 2, 1000000];
  console.log(args);
  const myTokenFactory = await ethers.getContractFactory("MyToken", deployer);
  const myToken = await myTokenFactory.deploy(
    args[0],
    args[1],
    args[2],
    args[3]
  );
  //await verify(myToken.getAddress(), args);
  console.log("coin deployed to", await myToken.getAddress());
}

//npx hardhat run scripts/deployCreateToken.js --network mumbai
//coin deployed to 0x4ABdb21e831d6a10dA657D9bb6d74C5170126e5D
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
