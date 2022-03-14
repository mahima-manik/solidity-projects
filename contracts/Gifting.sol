// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;

import "@quant-finance/solidity-datetime/contracts/DateTime.sol";

contract Gifting {

    /* Struct for storing Birthday and gifts received */
    struct Birthday {
        uint date;
        uint month;
        uint year;
        uint total;
        mapping (address => uint) gifts; // To be used later
    }

    /* Emitted when gift is sent to an address */
    event GiftSent(address sender, address receiver, uint amount);

    /* Emitted when an address withdraws the birthday fund */
    event HappyBirthday(address receiver, uint amount);

    uint totalBirthdays = 0;
    mapping (uint => address) indexes;
    mapping (address => Birthday) birthdays;
    
    /* Sets the Birthday for msg.sender */
    function set(uint _date, uint _month, uint _year) external {
        bool valid = checkValid(_date, _month, _year);
        require (valid == true, "Not a valid date");

        indexes[totalBirthdays++] = msg.sender;
        Birthday storage bday = birthdays[msg.sender];
        bday.date = _date;
        bday.month = _month;
        bday.year = _year;
    }
    
    /* Check if the date is valid */
    function checkValid(uint _date, uint _month, uint _year) public pure returns (bool) {
        bool valid = DateTime.isValidDate(_year, _month, _date);
        return valid;
    }

    /* Get the birthday of msg.sender */
    function get() external view returns (uint, uint, uint) {
        Birthday storage birthday = birthdays[msg.sender];
        bool valid = checkValid(birthday.date, birthday.month, birthday.year);
        require (valid == true, "Birthday does not exist");
        return (birthday.date, birthday.month, birthday.year);
    }

    /* Check if today is the birthday of msg.sender */
    function is_my_birthday() public view returns (bool) {
        Birthday storage birthday = birthdays[msg.sender];
        bool valid = checkValid(birthday.date, birthday.month, birthday.year);
        require (valid == true, "Birthday does not exist");
        
        uint time_now = block.timestamp;
        uint month_now = DateTime.getMonth(time_now);
        uint day_now = DateTime.getDay(time_now);
        
        if (month_now != birthday.month || day_now != birthday.date) return false;
        return true;
    }

    /* Send gift to receiver */
    function send_gift(address receiver) external payable {
        Birthday storage birthday = birthdays[receiver];
        bool valid = checkValid(birthday.date, birthday.month, birthday.year);
        require (valid == true, "Receiver's birthday does not exist");

        birthday.gifts[msg.sender] += msg.value;
        birthday.total += msg.value;
        emit GiftSent(msg.sender, receiver, birthday.total);
    }

    /* Withdraws the total gift of msg.sender from the contract */
    function bestow_gift() external payable {
        bool valid = is_my_birthday();
        require (valid == true, "Cannot withdraw funds outside your birthday");
        Birthday storage birthday = birthdays[msg.sender];

        payable(msg.sender).transfer(birthday.total);
        
        emit HappyBirthday(msg.sender, birthday.total);
        birthday.total = 0;
    }

    /* Returns the total gift received until now for msg.sender */
    function get_total_gift() public view returns (uint) {
        Birthday storage birthday = birthdays[msg.sender];
        bool valid = checkValid(birthday.date, birthday.month, birthday.year);
        require (valid == true, "Birthday does not exist");
        return birthdays[msg.sender].total;
    }

    /* Returns list of all addresses and birthdays stored on the contract */
    function get_all_birthdays() external view returns (address[] memory, uint[] memory, uint[] memory) {
        address[] memory adrs = new address[](totalBirthdays);
        uint[] memory dates = new uint[](totalBirthdays);
        uint[] memory months = new uint[](totalBirthdays);
        
        for (uint i = 0; i < totalBirthdays; i++)    {
            address adr = indexes[i];
            adrs[i] = adr;
            dates[i] = birthdays[adr].date;
            months[i] = birthdays[adr].month;
        }
        return (adrs, dates, months);
    }
}