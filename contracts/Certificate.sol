// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract Certificate {
    string title;
    mapping (address => bool) recipients;

    constructor(string memory _title, address _address)   {
        title = _title;
        recipients[_address] = true;
    }

    function add_recipient(address _address) external {
        recipients[_address] = true;
    }

    function verify_recipient(address _address) external view returns (bool) {
        return recipients[_address];
    }
}
