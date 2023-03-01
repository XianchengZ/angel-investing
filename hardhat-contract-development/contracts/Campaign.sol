// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract Campaign {
    struct Request {
        string description;
        uint value;
        // address recipient; // arguable
        bool complete;
    }

    // fields
    address public manager;
    uint256 public minimumContribution;
    mapping(address => uint256) investorsToFunding;
    Request[] public requests;

    // modifiers
    modifier restricted() {
        require(msg.sender == manager, "sender is not campaign manager");
        _;
    }

    constructor(uint256 minimum) {
        manager = msg.sender;
        minimumContribution = minimum;
    }

    function contribute() public payable {
        require(msg.value > minimumContribution, "not enough fund");

        investorsToFunding[msg.sender] += msg.value;
    }

    function createRequest(
        string memory description,
        uint value
    ) public restricted {
        Request memory newRequest = Request({
            description: description,
            value: value,
            complete: false
        });

        requests.push(newRequest);
    }
}
