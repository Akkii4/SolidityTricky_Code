// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;


contract Test{
    uint public testVar;
    address public owner;

    constructor(uint _testVar) payable{
        testVar = _testVar;
        owner = msg.sender;
    }

    function changeOwner(address newOwner) external{
        require(msg.sender == owner);
        owner = newOwner;
    }

    function getBalance() public view returns (uint){
        return (address(this)).balance;
    }
}