const Occasion = artifacts.require("Occasion");
const truffleAssert = require('truffle-assertions');

async function getBalanceInEther(account)    {
    balance = parseFloat(await web3.eth.getBalance(account));
    return balance;
}

contract("Occasion", (accounts) => {
    let my_birthday, my_birthday_date, my_birthday_month, my_birthday_year
    before(async () => {
        contractInstance = await Occasion.deployed();
        my_birthday = new Date (Date.now());
        my_birthday_date = my_birthday.getDate()
        my_birthday_month = my_birthday.getMonth()+1
        my_birthday_year = my_birthday.getFullYear()
    });

    it ('Check validity', async () => {
        const valid = await contractInstance.checkValid(my_birthday_date, my_birthday_month, my_birthday_year);
        console.log(valid)
    });

    it ('Set and check birthday', async () => {        
        console.log("Setting Birthday to: ", my_birthday_date, my_birthday_month, my_birthday_year)
        await contractInstance.set(my_birthday_date, my_birthday_month, my_birthday_year);
        const birthday = await contractInstance.get();
        
        birthday_date = birthday[0].toNumber()
        birthday_month = birthday[1].toNumber()
        birthday_year = birthday[2].toNumber()
        
        assert.equal(birthday_date, my_birthday_date, "Birthday date not set correctly")
        assert.equal(birthday_month, my_birthday_month, "Birthday month not set correctly")
        assert.equal(birthday_year, my_birthday_year, "Birthday year not set correctly")
    });

    // it ('Check if today is my birthday', async () => {        
    //     const is_my_birthday = await contractInstance.is_my_birthday();
    //     assert.equal(is_my_birthday, true, "Birthday should be today")
    // });

    it ('Send gift test', async () => {
        const giftAmount = web3.utils.toWei('1')
        const result = await contractInstance.send_gift(accounts[0], {from: accounts[1], value: giftAmount});
        contractFund = await web3.eth.getBalance(contractInstance.address)
        assert.equal(contractFund, giftAmount, "Contract fund not initialized conrrectly")
        truffleAssert.eventEmitted(result, 'GiftSent', (ev) => {
            assert.equal(ev.sender, accounts[1], "Sender address is not same")
            assert.equal(ev.receiver, accounts[0], "Receiver address is not same")
            assert.equal(ev.amount, giftAmount, "Gift amount is not same")
            return true;
        });        
    });

});
