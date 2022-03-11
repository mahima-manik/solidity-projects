// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;

import "@quant-finance/solidity-datetime/contracts/DateTime.sol";

contract Occasion {
    struct Birthday {
        uint date;
        uint month;
        uint year;
    }

    mapping (address => Birthday) birthdays;
    function set(uint _date, uint _month, uint _year) external {
        bool valid = DateTime.isValidDate(_year, _month, _date);
        require (valid == true, "Not a valid date");
        birthdays[msg.sender] = Birthday({date: _date, month: _month, year: _year});
    }

    function checkValid(uint _date, uint _month, uint _year) external pure returns (bool) {
        bool valid = DateTime.isValidDate(_year, _month, _date);
        return valid;
    }

    function get() external view returns (uint, uint, uint) {
        return (birthdays[msg.sender].date, birthdays[msg.sender].month, birthdays[msg.sender].year);
    }

    function is_my_birthday() external view returns (bool) {
        uint time_now = block.timestamp;
        uint month_now = DateTime.getMonth(time_now);
        uint day_now = DateTime.getDay(time_now);
        
        if (month_now != birthdays[msg.sender].month ||
            day_now != birthdays[msg.sender].date) return false;
        
        return true;
    }
}