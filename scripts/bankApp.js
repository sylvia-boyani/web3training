const hre = require("hardhat");

async function main() {
    //body
    const signers = await hre.ethers.getSigners();
    console.log("signers::", signers);

    const account0 = signers [0].address;
    const BankApp = await hre.ethers.getContractFactory(BankApp);
    const bankApp = await bankApp.deploy("Loibon");
    await bankApp.deployed();

    await bankApp.deployed();
    await bankApp.register("0x70997970C51812dc3A010C7d01b50e0d17dc79C8", "1234", "John", "fdvgydg5" )

    //login user
    await bankApp.connect(signers[0].login)
}

main().catch((error) =>{
console.error(error);
process.exitCode =1;
})
