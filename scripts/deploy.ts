import { ethers } from "hardhat";


async function main() {
    const address1 = "0x1234567890123456789012345678901234567890";
    const address2 = "0x0987654321098765432109876543210987654321";

    // Instantiate AAVEIntegration class with dummy addresses
    const aave = await ethers.deployContract("AAVEIntegration", [address1, address2], { });

    // Deploy the contract
    await aave.waitForDeployment();

    // Print the address where the contract was deployed to
    aave.getAddress().then((address) => {
        console.log("AAVEIntegration deployed to:", address);
    });

}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
