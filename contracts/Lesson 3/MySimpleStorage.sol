// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract MySimpleStorage {

    mapping(string => uint256) people;

    string[] public listOfNames;

    modifier personExists(string memory _name) {
        require(people[_name] != 0, "This person does not exist.");
        _;
    }

    function newPerson(uint256 _favoriteNumber, string memory _name) public  {
        people[_name] = _favoriteNumber;
        listOfNames.push(_name);
    }

    function getPersonFavoriteNumber(string memory _name) personExists(_name) public view returns(uint256) {
        return people[_name];
    }

    function addTwoPeopleFavoriteNumbers(string memory _firstName, string memory _secondName) public view returns(uint256) {
        return getPersonFavoriteNumber(_firstName) + getPersonFavoriteNumber(_secondName);
    }

    function sumOfFavoriteNumbers() public view returns(uint256) {
        uint256 sum;
        for(uint256 i = 0; i < listOfNames.length; i++) {
            sum += people[listOfNames[i]];
        }
        return sum;
    }
}