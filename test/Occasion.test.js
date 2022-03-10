const Occasion = artifacts.require("Occasion");

contract("Occasion", (accounts) => {
    before(async () => {
        contractInstance = await Occasion.deployed();
    });

    it ('Set and check birthday', async () => {
        const my_birthday = Date.now();
        await contractInstance.set(my_birthday);
        const get_birthday = await contractInstance.get();
        assert.equal(my_birthday, get_birthday, "Birthday not set correctly")
    });

});
