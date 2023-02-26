// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract Campaign {
    address public manager;
    uint256 public minimumContribution;
    mapping(address => uint256) investorsToFunding;

    constructor(uint256 minimum) {
        manager = msg.sender;
        minimumContribution = minimum;
    }

    function contribute() public payable {
        require(msg.value > minimumContribution);

        investorsToFunding[msg.sender] += msg.value;
    }
}
