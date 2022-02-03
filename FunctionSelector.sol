// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
// This Contract lets you compute the function's selector which is the first 4 bytes of the function signature.

contract FunctionSelector {
    function test(address _target, uint _num) public pure returns(bytes4 functionSig) {
        functionSig = bytes4(msg.data);
    }

    function getSelector(string calldata _function) public pure returns (bytes4) {
        return bytes4(keccak256(bytes(_function)));
    }
}
