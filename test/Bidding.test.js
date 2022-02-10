const Bidding = artifacts.require("Bidding");

function timeout(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

async function getBalanceInEther(account)    {
    balance = parseFloat(await web3.eth.getBalance(account));
    return balance;
}

// in memory virtual blockchain
contract("Bidding", (accounts) => {
    before(async () => {
        contractInstance = await Bidding.deployed();
        winnerInitialBalance = await getBalanceInEther(accounts[1]);
    });

    it ('Check bidding duration before start', async () => {
        let duration = await contractInstance.biddingDuration();
        assert.equal(0, duration, "Bidding duration should be 0 at the beginning");
    })

    it ('Start Bidding', async () => {
        const txParams = {
            from: accounts[0],
            value: 20
        };
        await contractInstance.startBidding(5, txParams);
        let duration = await contractInstance.biddingDuration();
        assert.equal(5, duration, "Bidding duration not set to 5");
    });

    it ('Place a bet and check winner when bidding period is not over', async () => {
        const txParams = {
            from: accounts[1],
            value: 30
        };
        await contractInstance.bet(txParams);
        try {
            await contractInstance.winner();
            assert.fail("The transaction should have thrown an error");
        } catch (err) {
            assert.include(err.message, "revert Bidding duration is not over yet", "The error message is not correct");
        }
    });

    it ('Check winner after the bidding period is over', async() => {
        await timeout(5000);
        let beforeBalance = await getBalanceInEther(accounts[1]);
        let ans = await contractInstance.winner();
        let afterBalance = await getBalanceInEther(accounts[1]);
        assert.equal(afterBalance, beforeBalance + parseFloat(web3.utils.fromWei("50")),
            "Bidding amount was not transferred successfully");
    });

})