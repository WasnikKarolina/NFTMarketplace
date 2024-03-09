
    /*
Save The Private Key in the .env file
PRIVATE_KEY="YOUR PRIVATE KEY"
Important: Add the .env file to your .gitignore
*/
import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
require('dotenv').config()

const config: HardhatUserConfig = {
  solidity: "0.8.20",
  networks: {
    "leopardwest": {
      url: "https://leopardwest-rpc.eu-north-2.gateway.fm",
      chainId: 2131903211,
      accounts: [`0x${process.env.PRIVATE_KEY}`],
      // accounts: [`0x58ea20666f47353d11a7e00e0fa66605f2bf912c0f93d36374a4178cbf6671a3`],
      gasPrice: 0
    }
  }
};

export default config;
    