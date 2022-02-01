// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
//Caller contract delegatecall to Target contract.
// If the user calls Caller contract, Caller contract will delegatecall to Target contract and function would be executed. 
// But all state changes will be reflect Caller contract storage, not Target contract.

// NOTE: Deploy this contract first
contract Target {
    // NOTE: storage layout must be the same as contract A
    uint public num;
    address public sender;
    uint public amountSent;

    function set(uint _num) public payable {
        num = _num;
        sender = msg.sender;
        amountSent = msg.value;
    }
}

contract Caller {
    // after delegatecall, the varaiables of Caller contract will be updated
    uint public num;
    address public sender;
    uint public amountSent;

    function set(address _target, uint _num) public payable {
        // A's storage is set, B is not modified.
        (bool success, bytes memory data) = _target.delegatecall(
            abi.encodeWithSignature("set(uint256)", _num)
        );
        require(success, "delegatecall failed");
        // do something with data
    }
}
