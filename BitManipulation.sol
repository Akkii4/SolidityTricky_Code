// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract BitManipulation {
    // access a bit (0 or 1) at a index of Number (accessed as binary) 
    function accessBit(uint8 number, uint8 index) external pure returns (uint8 bit){
        return (number >> index) & uint8(1);
    }

    // sets a bit (0 or 1) at a index of Number (accessed as binary) and retutrns modified Number
    function setBit(uint8 number, uint8 index, uint8 bit) external pure returns (uint8 modifiedNumber){
        require(bit < 2, "Only 0 or 1");
        return bit == 0 ? (((uint8(1) << index) & number) ^ number) : ((uint8(1) << index) | number);
    }
}
