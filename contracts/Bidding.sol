// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Bidding {
    address private highestBidder;
    uint private highestBid;
    uint private totalBid;
    uint public biddingDuration;
    uint public biddingStartTime;

    event BiddingStarts(uint biddingStartTime);
    event WinnerDeclared(address highestBidder, uint amount);

    function startBidding(uint biddingTime) external payable {
        require(block.timestamp >= biddingStartTime + biddingDuration,
            "Bidding is in  progress, please wait");
        require(totalBid == 0, "Winner has not been paid out yet.");
        require(msg.value > 0,
            "Bidding should be started with some initial funds.");
        biddingDuration = biddingTime;
        biddingStartTime = block.timestamp;
        totalBid += msg.value;
        highestBid = msg.value;
        highestBidder = msg.sender;
        emit BiddingStarts(biddingDuration);
    }

    function bet() external payable {
        require (block.timestamp < biddingStartTime + biddingDuration,
            "Bidding is already over, please restart");
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
        address winnerAddress = highestBidder;
        totalBid = 0;
        highestBid = 0;
        biddingStartTime = 0;
        highestBidder = address(0);
        emit WinnerDeclared(highestBidder, totalBid);
        return winnerAddress;
    }
}