import * as dotenv from "dotenv";

import { HardhatUserConfig, task } from "hardhat/config";
import "@nomiclabs/hardhat-etherscan";
import "@nomiclabs/hardhat-waffle";
import "@typechain/hardhat";
import "hardhat-gas-reporter";
import "solidity-coverage";

dotenv.config();

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("deployKovan", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

const config: HardhatUserConfig = {
  solidity: "0.6.6",
  defaultNetwork: "kovan",
  networks: {
    kovan: {
      url: "https://kovan.infura.io/v3/ba4a0bdfd515437bb4f90357fd5758fe",
      accounts: [`e59531fb18930ee6d564d02c7f466725b21db879fe1c96d9767caeb6ae69c23c`],
    },
  },
};

export default config;
