const hre = require("hardhat");

async function main() {
  // Get the contract name from command-line arguments
  const args = process.argv.slice(2);
  const contractName = "PurchaseOrderWithWarranty"

  // Fetch the contract factory
  const ContractFactory = await hre.ethers.getContractFactory(contractName);

  // Deploy the contract
  console.log(`Deploying ${contractName}...`);
  const contract = await ContractFactory.deploy();

  // Wait for the deployment transaction to be mined
  await contract.waitForDeployment();

  // Get the deployed contract address
  const address = await contract.getAddress();

  // Log the contract address
  console.log(`${contractName} deployed to:`, address);
}

// Handle errors during deployment
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
