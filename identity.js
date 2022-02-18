const IdentityContract = artifacts.require("IdentityManagement");

module.exports = async function(callback) {

    let accounts = await web3.eth.getAccounts();

    let instance = await IdentityContract.deployed();
    console.log("Contract instance fetched: ", instance.address);
    let result = null;
    try {
        result = await instance.add_certificate("Santa Clara University", "scu.edu", {from: accounts[0]});
        console.log(typeof(result.logs[0].args), result.logs[0].args, result.logs[0].args[0]);
    } catch (error) {
        console.log(error);
    }

    try {
        console.log(result.receipt.rawLogs[0]);
        await instance.issue_certificate(accounts[1], result.logs[0].args[0],
            "https://ipfs.io/ipfs/QmaZmECGK1fUyuVtp6VJHjBBPgcETGnN6fS2AsDcGLsXBV", {from: accounts[0]}
            );

//     await instance.issue_certificate("0x25B19126A114eef407621B159441b259a316fBAA",
//                "0xde40c92f4ff5288acf40df9ae18a96413fa45154",
//                "https://ipfs.io/ipfs/QmaZmECGK1fUyuVtp6VJHjBBPgcETGnN6fS2AsDcGLsXBV",
//                {from: "0xcf132245B942046bc8b937Ce169668511F6ac119"});
        console.log("Minting certificate successful");
    } catch (error) {
        console.log(error);
    }
    callback();
}