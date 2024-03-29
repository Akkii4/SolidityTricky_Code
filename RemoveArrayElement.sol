// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract RemoveArrayElement {

    modifier checkIndex(uint _index, uint _arrLength){
        require(_index < _arrLength, "Index out of bounds");
        _;
    }

    // Remove an element by shifting each to left, it preserves order, but consumes more gas
    function removeElement(uint256[] memory a, uint256 index) public checkIndex(index, a.length) pure returns (uint256[] memory) {
        
        uint256[] memory result = new uint256[](a.length - 1);
        for (uint256 i = 0; i < index; i++) {
            result[i] = a[i];
        }
        for (uint256 i = index; i < result.length; i++) {
            result[i] = a[i + 1];
        }
        return result;
    }

    /**
    * it removes array element by changing the element to be replaced by the element at last index
    * more effecient in gas but doesn't preserve order
    */
    function removeElement2(uint256[] memory a, uint256 index) public checkIndex(index, a.length) pure returns (uint256[] memory result) {
        uint256 newArrLength = a.length - 1;
        
        result = new uint256[](newArrLength);
        
        for (uint256 i = 0; i < newArrLength; i++) {
            result[i] = a[i];
            if(i == index) result[index] = a[newArrLength];
        }  

        
    }

}
