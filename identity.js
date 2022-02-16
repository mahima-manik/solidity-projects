const IdentityContract = artifacts.require("IdentityManagement");

module.exports = async function() {

//    let accounts = await web3.eth.getAccounts();
    console.log(IdentityContract.address);
    let instance = await IdentityContract.at(IdentityContract.address);

    await instance.add_certificate("Hello World", "HWD");
    console.log("Adding certificate successful");

    await instance.issue_certificate("0xE0B647801629001Bc23B329df39E6A542d06F3d6", "https://ipfs.io/ipfs/QmZf2GXC5mTJEZXUiHyG47rZsnhhPFLFCKyvghGjYy92B5");
    console.log("Minting certificate successful");
}