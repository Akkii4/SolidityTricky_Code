// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract AccessCodeInfo {
    
    //query the deployed code for any smart contract
    function accessCode(address _contractAddr) external view returns(bytes memory, bytes32){
        return (
            _contractAddr.code,     // gets the EVM bytecode of code
            _contractAddr.codehash  // Keccak-256 hash of that code
        );
    }
    
}
