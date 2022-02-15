// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.11;

import "./Certificate.sol";

contract IdentityManagement {

    mapping (address => Certificate) private authorities;

    function add_certificate(string memory _title) external {
        authorities[msg.sender] = new Certificate(_title, msg.sender);
    }

    function issue_certificate(address _receiver) external {
        Certificate certificate = authorities[msg.sender];
        require (certificate.verify_recipient(msg.sender), "Not authorized to issue this certificate");
        certificate.add_recipient(_receiver);
    }

    function verify_certificate(address _recipient, address _issuer) external view returns (bool) {
        Certificate cert = authorities[_issuer];
        return cert.verify_recipient(_recipient);
    }
}
