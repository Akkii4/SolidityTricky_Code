// SPDX-License-Identifier: TOO_BUSY_FOR_COURT
pragma solidity ^0.8.0;

contract StringOperations {
    function getStringLength(string calldata s) public pure returns (uint) {
        return bytes(s).length;
    }

    function concatenateStrings(string calldata a, string calldata b) public pure returns (string memory) {
        return string(abi.encodePacked(a,b));
    }

    function reverseStrings(string calldata s) public pure returns (string memory) {
        bytes memory b = bytes(s);
        string memory r = new string(b.length);
        bytes memory rb = bytes(r);
        for(uint i = 0; i < b.length; i++) {
            rb[i] = b[b.length - i - 1];
        }
        return string(rb);
    }

    function compareString(string calldata a, string calldata b) public pure returns (bool) {
        return keccak256(abi.encodePacked(a)) == keccak256(abi.encodePacked(b));
    }
}