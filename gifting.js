const GiftingContract = artifacts.require("Gifting");

async function getBalanceInEther(account)    {
    balance = parseFloat(await web3.eth.getBalance(account));
    return balance;
}

module.exports = async function(callback) {

    let accounts = await web3.eth.getAccounts();

    let contractInstance = await GiftingContract.deployed();
    console.log("Contract instance fetched: ", contractInstance.address);
    
    let my_birthday, my_birthday_date, my_birthday_month, my_birthday_year
    my_birthday = new Date (Date.now());
    my_birthday_date = my_birthday.getDate()
    my_birthday_month = my_birthday.getMonth()+1
    my_birthday_year = my_birthday.getFullYear()

    // Check if birthday is a valid date
    const valid = await contractInstance.checkValid(my_birthday_date, my_birthday_month, my_birthday_year);
    console.log("Is valid birthday: ", valid)

    // Set birthday for few addresses
    console.log("Setting Birthday to: ", my_birthday_date, my_birthday_month, my_birthday_year)
    await contractInstance.set(my_birthday_date, my_birthday_month, my_birthday_year, {from: accounts[0]});
    await contractInstance.set(my_birthday_date+3, my_birthday_month+2, my_birthday_year, {from: accounts[2]});
    await contractInstance.set(my_birthday_date+10, my_birthday_month+5, my_birthday_year, {from: accounts[3]});
    const birthday = await contractInstance.get();
    
    birthday_date = birthday[0].toNumber()
    birthday_month = birthday[1].toNumber()
    birthday_year = birthday[2].toNumber()
    
    console.log(birthday_date, my_birthday_date)
    console.log(birthday_month, my_birthday_month)
    console.log(birthday_year, my_birthday_year)

    // Send gift and check if contract fund has increased
    const giftAmount = web3.utils.toWei('1')
    let result = await contractInstance.send_gift(accounts[0], {from: accounts[1], value: giftAmount});
    let contractFund = await web3.eth.getBalance(contractInstance.address)

    console.log("Contract fund is: ", contractFund)

    // Get total gift of an address
    result = await contractInstance.get_total_gift({from: accounts[0]});
    console.log("Total gift is: ", result.toString());

    // List all addresses and birthdays
    result = await contractInstance.bestow_gift({from: accounts[0]});
    contractFund = await web3.eth.getBalance(contractInstance.address)
    console.log("Contract fund is now: ", contractFund)

    result = await contractInstance.get_all_birthdays()
    console.log(result[0])
    console.log(result[1])
    console.log(result[2])
    
    callback();
}