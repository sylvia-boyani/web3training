require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  networks:{
    hardhat: {},
    mumbai: {
    url: "https://polygon-mumbai.g.alchemy.com/v2/F9F4p8jZFo9sI4TCaJfHiibeAINe6bag",
    accounts: ["3ed6ca60eed60d333f229d6573945190fda4e9ef43e77f8c0b4318d703694515"],
    chainId: 80001,
  },

},
solidity: "0.8.9",
  };
