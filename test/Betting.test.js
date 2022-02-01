const Bidding = artifacts.require("Bidding");

function timeout(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

// in memory virtual blockchain
contract("Bidding", (accounts) => {
    before(async () => {
        contractInstance = await Bidding.deployed();
    });

    it ('Check bidding duration before start', async () => {
        let duration = await contractInstance.biddingDuration();
        assert.equal(0, duration, "Bidding duration should be 0 at the beginning");
    })

    it ('Start Bidding', async () => {
        await contractInstance.startBidding(5);
        let duration = await contractInstance.biddingDuration();
        assert.equal(5, duration, "Bidding duration not set to 5");
    });

    it ('Place a bet and check winner when bidding period is not over', async () => {
        const txParams = {
            from: accounts[0],
            value: 10
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
        let winner = await contractInstance.winner();
        assert(winner, accounts[0], "Winner is right address");
    });

})