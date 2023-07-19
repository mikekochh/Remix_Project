// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {PriceConverter} from "./PriceConverter.sol";

// 1,379,100 
// 1,329,053 

error NotOwner();

contract FundMe {
    using PriceConverter for uint256;

    uint256 public MINIMUM_USD = 5e18;

    string[] public fundersNames;

    struct Funder {
        address walletAddress;
        uint256 fundAmount;
    }

    mapping(string => Funder) public funders;

    address public i_owner;

    constructor() {
        i_owner = msg.sender;
    }

    function fund(string memory _name) public payable enoughEthSent {
        fundersNames.push(_name);
        funders[_name] = Funder(msg.sender, funders[_name].fundAmount + msg.value);
    }

    function fundUserAmount(string memory _name) public view returns(uint256) {
        return funders[_name].fundAmount;
    }

    function withdraw() public onlyOwner { 
        for(uint256 funderIndex = 0; funderIndex < fundersNames.length; funderIndex++) {
            string memory _name = fundersNames[funderIndex];
            funders[_name].fundAmount = 0;
        }
        fundersNames = new string[](0);

        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }

    modifier onlyOwner() {
        // require(msg.sender == i_owner, "Sender is not owner");
        if (msg.sender != i_owner) { revert NotOwner(); }
        _;
    }

    modifier enoughEthSent() {
        require(msg.value.getConversionRate() >= MINIMUM_USD, "didn't send enough ETH");
        _;
    }

    receive() external payable {
        fund("External Source");
    }

    fallback() external payable {
        fund("External Source");
    }
}