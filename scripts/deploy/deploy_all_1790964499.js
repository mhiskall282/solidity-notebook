const hre = require("hardhat");

async function main() {
  console.log("🚀 Deployment Script Execution");
  console.log("================================");
  
  const [deployer] = await hre.ethers.getSigners();
  console.log("Deployer:", deployer.address);
  console.log("Balance:", hre.ethers.formatEther(await hre.ethers.provider.getBalance(deployer.address)));
  console.log("Network:", hre.network.name);
  console.log("Chain ID:", (await hre.ethers.provider.getNetwork()).chainId);
  console.log("Block Number:", await hre.ethers.provider.getBlockNumber());
  console.log("Gas Price:", hre.ethers.formatUnits(await hre.ethers.provider.getGasPrice(), "gwei"), "gwei");
  console.log("================================");
  console.log("✅ Ready for deployment");
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
