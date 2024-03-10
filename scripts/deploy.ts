import { ethers } from "hardhat";

async function main() {
  // const currentTimestampInSeconds = Math.round(Date.now() / 1000);
  // const unlockTime = currentTimestampInSeconds + 60;
  const user = "0x3a3E804929EcdcE6B880a2A05516526C94B8296C";

  const lockedAmount = ethers.parseEther("0.001");

  const lock = await ethers.deployContract("Market", [user], );

  await lock.waitForDeployment();

  console.log(
    `User ${user} logged in`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
