// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;

import "@quant-finance/solidity-datetime/contracts/DateTime.sol";

contract Occasion {
    struct Birthday {
        uint date;
    }

    mapping (address => Birthday) birthdays;
    function set(uint _my_birthday) external {
        birthdays[msg.sender] = Birthday({date: _my_birthday});
    }

    function get() external view returns (uint) {
        return birthdays[msg.sender].date;
    }

    function getMonth() external view returns (uint)    {
        return DateTime.getMonth(birthdays[msg.sender].date);
    }
}