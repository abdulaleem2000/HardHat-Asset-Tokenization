const { ethers, getNamedAccounts } = require("hardhat");

async function main() {
  const { deployer } = await getNamedAccounts();
  const assetTokenSale = await ethers.getContract("AssetTokenSale", deployer);
  console.log(`Got contract FundMe at ${assetTokenSale.address}`);
  //console.log("Withdrawing from contract...");
  const transactionResponse = await assetTokenSale.purchaseTokens({
    value: ethers.utils.parseEther("0.2"),
  });
  await transactionResponse.wait();
  console.log("Got it back!");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
