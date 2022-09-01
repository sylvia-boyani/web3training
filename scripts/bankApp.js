const hre = require("hardhat");

async function main() {
    //body
    const signers = await hre.ethers.getSigners();

    const account0 = signers[0].address;
    const account1 = signers[1].address;

    const BankApp = await hre.ethers.getContractFactory("BankApp");
    const bankApp = await BankApp.deploy("Loibon");
    await bankApp.deployed();

    //Account0
    await bankApp.register(account0, 1234, "John", "A004edddf3", 0);

    //Account1
    await bankApp.register(account1, 4567, "Mesh", "A004dddee3", 10);

    await bankApp.deployed();

    //login user
    await bankApp.connect(signers[0]).login();

    //deposit
    await bankApp.connect(signers[0]).deposit(1000);

    //balance
    console.log (await bankApp.connect(signers[0]).balanceOf(account0));

    //transfer to account2
    // await bankApp.connect(signers[0]).transfer(account)


}

main().catch((error) =>{
console.error(error);
process.exitCode =1;
})
