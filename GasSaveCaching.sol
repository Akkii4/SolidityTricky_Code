// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
// Reading & doing operation on a memory variables(cache) is cheaper when compared to that from storage variable(non cache)

contract GasSaveCaching {
    uint public num = 50;

    // for num = 50 , it takes 47605 gas
    function noCache() public view returns(uint256 op) {
        for (uint i = 0; i < num; i++) {
            op += 1;
        }
    }

    // for num = 50 , it takes 42588 gas
    function cache() public view returns(uint256 op) {
        uint _num = num;
        for (uint i = 0; i < _num; i++) {
            op += 1;
        }
    }
}
