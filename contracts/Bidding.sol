// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Bidding {
    address private highestBidder;
    uint public highestBid;
    uint private totalBid;
    uint public biddingDuration;
    uint public biddingStartTime;

    event BiddingStarts(uint biddingStartTime);
    event WinnerDeclared(address highestBidder, uint amount);
//    event BiddingNotOverYet(uint biddingStartTime, uint biddingDuration);



    function startBidding(uint biddingTime) external {
        biddingDuration = biddingTime;
        biddingStartTime = block.timestamp;
        emit BiddingStarts(biddingDuration);
    }
    function bet() external payable {
        if (block.timestamp < biddingStartTime + biddingDuration)
        totalBid += msg.value;
        if (msg.value > highestBid) {
            highestBid = msg.value;
            highestBidder = msg.sender;
        }
    }

    function winner() external payable returns (address) {
        require (block.timestamp >= biddingStartTime + biddingDuration,
            "Bidding duration is not over yet");
        payable(highestBidder).transfer(totalBid);
        emit WinnerDeclared(highestBidder, totalBid);
        totalBid = 0;
        highestBid = 0;
        biddingStartTime = block.timestamp;
        // TODO: set highestBidder to 0x0
        return highestBidder;
    }
}