// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
// remix is smart enough to know that this is referencing a npm package @chainlink/contracts, esssentially downloading from the github

library PriceConverter {

        function getPrice() internal view returns (uint256) {
        // what this is doing is creating an object that is an instance of the smart contract interface using that address (and that address is for Sepolia ETH/USD
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (, int256 price,  ,  ,  ) = priceFeed.latestRoundData();
        // here, this function is returning a lot of variables, but we just want the price so we leave other fields empty and only sepcify price
        return uint256(price * 1e10);
    }

    function getConversionRate(uint256 ethAmount) internal view returns(uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }

    function getVersion() internal view returns (uint256) {
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }

}