// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.11;

//import "./Certificate.sol";
import "./Cert.sol";

contract IdentityManagement {

    mapping (address => address) public authorities;

    function add_certificate(string memory _name, string memory _symbol) external returns (address) {
        Cert cert = new Cert(_name, _symbol); // returns bytecode
        // Not storing bytecode, as it will become expensive
        address tokenAddress = cert.contractAddress();
        authorities[msg.sender] = tokenAddress;
        return tokenAddress;
    }

    function issue_certificate(address _receiver, string memory tokenURI) external returns (uint) {
        address contractAddress = authorities[msg.sender];
        Cert certificate = Cert(contractAddress);
        require (contractAddress != address(0), "No certificate exists for this user");
        return certificate.mint(tokenURI, _receiver);
    }

//    function verify_certificate(address _recipient, address _issuer) external view returns (bool) {
//        Certificate cert = authorities[_issuer];
//        return cert.verify_recipient(_recipient);
//    }
}
