// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

// with the curly brackets, we can specifiy which smart contract we want to import, instead of having to import the entire file
import {SimpleStorage} from "./SimpleStorage.sol";
import {MySimpleStorage} from "./MySimpleStorage.sol";

contract StorageFactory {

    // Simple Storage
    
    SimpleStorage[] public listOfSimpleStorageContracts;

    function createSimpleStorageContract() public {
        listOfSimpleStorageContracts.push(new SimpleStorage());
    }

    function sfStore(uint256 _simpleStorageIndex, uint256 _newSimpleStorageNumber) public {
        SimpleStorage simpleStorage = listOfSimpleStorageContracts[_simpleStorageIndex];
        simpleStorage.store(_newSimpleStorageNumber);
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns(uint256) {
        SimpleStorage simpleStorage = listOfSimpleStorageContracts[_simpleStorageIndex];
        return simpleStorage.retrieve();
    }


    // My Simple Storage (Array version)

    MySimpleStorage[] public listOfMySimpleStorageContracts;

    function createMySimpleStorageContract() public {
        listOfMySimpleStorageContracts.push(new MySimpleStorage());
    }

    function msfStore(uint256 _mySimpleStorageIndex, uint256 _newFavoriteNumber, string memory _newPersonName) public {
        MySimpleStorage mySimpleStorage = listOfMySimpleStorageContracts[_mySimpleStorageIndex];
        mySimpleStorage.newPerson(_newFavoriteNumber, _newPersonName);
    }

    function msfGetFavoriteNumber(uint256 _mySimpleStorageIndex, string memory _name) public view returns(uint256) {
        MySimpleStorage mySimpleStorage = listOfMySimpleStorageContracts[_mySimpleStorageIndex];
        return mySimpleStorage.getPersonFavoriteNumber(_name);
    }

    function msfAddTwoFavoriteNumbers(uint256 _mySimpleStorageIndex, string memory _firstName, string memory _secondName) public view returns(uint256) {
        MySimpleStorage mySimpleStorage = listOfMySimpleStorageContracts[_mySimpleStorageIndex];
        return mySimpleStorage.addTwoPeopleFavoriteNumbers(_firstName, _secondName);
    }


    // My Simple Storage (mapping version)
    mapping(string => MySimpleStorage) public familySimpleStorage;

    modifier familyNameNotBlank(string memory _familyName) {
        require (bytes(_familyName).length > 0, "Must supply family name");
        _;
    }

    function createFamilySimpleStorage(string memory _familyName) familyNameNotBlank(_familyName) public {
        familySimpleStorage[_familyName] = new MySimpleStorage();
    }

    function familyStore(string memory _familyName, uint256 _favoriteNumber, string memory _personName) public {
        familySimpleStorage[_familyName].newPerson(_favoriteNumber, _personName);
    }

    function familyGetFavoriteNumber(string memory _familyName, string memory _personName) public view returns(uint256) {
        return familySimpleStorage[_familyName].getPersonFavoriteNumber(_personName);
    }

    function familyAddTwoFavoriteNumbers(string memory _familyName, string memory _firstName, string memory _secondName) public view returns(uint256) {
        return familySimpleStorage[_familyName].addTwoPeopleFavoriteNumbers(_firstName, _secondName);
    } 

    function familyFavoriteNumberSum(string memory _familyName) public view returns(uint256) {
        return familySimpleStorage[_familyName].sumOfFavoriteNumbers();
    }

    function betterFamilyFavoriteNumbersSum(string memory _firstFamilyName, string memory _secondFamilyName) public view returns(string memory) {
        if (familyFavoriteNumberSum(_firstFamilyName) > familyFavoriteNumberSum(_secondFamilyName)) {
            return _firstFamilyName;
        }
        return _secondFamilyName;
    }
    
    function compareFavoriteNumbersAnyFamily(
        string memory _firstPersonFirstName,
        string memory _firstFamilyName,
        string memory _secondPersonFirstName,
        string memory _secondFamilyName) public view returns(string memory) {
            if (familyGetFavoriteNumber(_firstFamilyName, _firstPersonFirstName) > familyGetFavoriteNumber(_secondFamilyName, _secondPersonFirstName)) {
                return _firstPersonFirstName;
            }
            return _secondPersonFirstName;
    }


}