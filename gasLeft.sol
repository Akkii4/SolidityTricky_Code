// SPDX-License-Identifier: MIT
/**
gasleft() is used to prevent : 
  - out-of-gas errors
  - calculating solidity code execution cost
  - forwarding remaining gas to implementation contracts
  - for preventing relayer DOS
*/
pragma solidity ^0.8.19;

contract ValidateGasTransfer{
    uint constant MINIMUM_GAS_REQUIRED = 10_000;

    receive() external payable {}
  
    function trasnferEther(address[] calldata users) external {
        for (uint i = 0; i < users.length; i++) {
            
            payable(users[i]).transfer(1 ether);
            
            if (gasleft() < MINIMUM_GAS_REQUIRED) break;
        }
    }
}

// Warning : Above code is only for illustration purposes, as any of the reciever's address if turns out to be a malicious smart contract can reverts the receiving ether.
