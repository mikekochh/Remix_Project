// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {SimpleStorage} from "./SimpleStorage.sol";

// this makes the AddFiveStorage contract a child contract of the SimpleStorage contract
// now, we can access all functions and variables in SimpleStorage in AddFiveStorage
contract AddFiveStorage is SimpleStorage {

    function sayHello() public pure returns(string memory) {
        return "Hello";
    }

    // if you are inheriting a contract, you cannot create a new function the same name without override key word
    function store(uint256 _newNumber) public override {
        myFavoriteNumber = _newNumber + 5;
    }
}