// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;

import "@quant-finance/solidity-datetime/contracts/DateTime.sol";

contract Occasion {
    struct Birthday {
        uint date;
        uint month;
        uint year;
        mapping (address => uint) gifts;
    }

    event GiftSent(address sender, address receiver, uint amount);

    uint total = 0;
    mapping (uint => address) indexes;
    mapping (address => Birthday) birthdays;
    
    function set(uint _date, uint _month, uint _year) external {
        bool valid = checkValid(_date, _month, _year);
        require (valid == true, "Not a valid date");
        indexes[++total] = payable(msg.sender);
        Birthday storage bday = birthdays[msg.sender];
        bday.date = _date;
        bday.month = _month;
        bday.year = _year;
    }

    function checkValid(uint _date, uint _month, uint _year) public pure returns (bool) {
        bool valid = DateTime.isValidDate(_year, _month, _date);
        return valid;
    }

    function get() external view returns (uint, uint, uint) {
        return (birthdays[msg.sender].date, birthdays[msg.sender].month, birthdays[msg.sender].year);
    }

    function is_my_birthday() public view returns (bool) {
        uint time_now = block.timestamp;
        uint month_now = DateTime.getMonth(time_now);
        uint day_now = DateTime.getDay(time_now);
        
        if (month_now != birthdays[msg.sender].month ||
            day_now != birthdays[msg.sender].date) return false;
        
        return true;
    }

    function send_gift(address receiver) external payable {
        Birthday storage birthday = birthdays[receiver];
        bool valid = checkValid(birthday.date, birthday.month, birthday.year);
        require (valid == true, "Receiver's birthday does not exist");

        birthday.gifts[msg.sender] += msg.value;
        emit GiftSent(msg.sender, receiver, msg.value);
    }

    // function bestow_gift() external payable {
    //     bool valid = is_my_birthday();
    //     require (valid == true, "Cannot withdraw funds outside your birthday");
    //     Birthday storage birthday = birthdays[msg.sender];
    //     bool valid = checkValid(birthday.date, birthday.month, birthday.year);
    //     require (valid == true, "Receiver's birthday does not exist");

    //     birthday.gifts[msg.sender] += msg.value;
    //     emit GiftSent(msg.sender, receiver, msg.value);
    // }

    // function get_total_gift() {
    //     birthdays[msg.sender].gifts;
    // }

    // function get_all_birthdays() external view returns (address[], uint[], uint[]) {
    //     address[] memory adrs;
    //     address[] memory dates;
    //     address[] memory months;
    //     for (uint i = 0; i < total; i++)    {
    //         address adr = indexes[i];
    //         dates.Birthday[adr].date;
    //     }
    // }

}