// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.11;

contract IdentityManagement {
    struct Certificate {
        string title;
        mapping (address => bool) recipients;
    }

    mapping (address => Certificate) private authorities;

    function add_certificate(string memory _title) external {
        Certificate storage certificate = authorities[msg.sender];
        certificate.title = _title;
        certificate.recipients[msg.sender] = true;
    }

    function issue_certificate(address _receiver) external {
        Certificate storage certificate = authorities[msg.sender];
        require (certificate.recipients[msg.sender], "Not authorized to issue this certificate");
        certificate.recipients[_receiver] = true;
    }

    function verify_certificate(address _recipient, address _issuer) external view returns (bool) {
        Certificate storage cert = authorities[_issuer];
        return cert.recipients[_recipient];
    }
}
