// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
/**
max integer that can be stored in solidity is via uint256 (2^256 - 1) equals 115792089237316195423570985008687907853269984665640564039457584007913129639935
OR 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff (64 hex characters/ 32 bytes)
*/
contract IntegerMax {
    // Most recommended way to get any data type max value
    function uint256Max() public pure returns (uint256) {
        return type(uint256).max;
    }

    // although this solution works but not recommended as can cause overflow
    function maxUint() public pure returns (uint256 r) {
        r = 2**256 - 1;
        assert(2**256 - 1 == uint256Max());
    }

    // this also results in getting largest number as it underflows
    function maximum() public pure returns (uint256) {
         unchecked { return uint256(0) - uint256(1); }
    }

    // ~(NOT operator) inverts each bits i.e 0 to 1 and viz-a-viz
    function biggestUint() public pure returns (bool) {
        return uint256Max() == ~uint256(0); // is true
    }
    
    // solidity doesn't allow explicit type conversion from int to uint
    // function depreceatedMaxUint() public pure returns (uint256) {
    //     return uint256(-1);
    // }

    /**
     Solidity uses 2's complement for signed integers 
     formula positive int : 2^(N-1) - 1 
             negative int : -(2^(N-1))
    */
    function int256Extreme() public pure returns (int256 max, int256 min) {
        //57896044618658097711785492504343953926634992332820282019728792003956564819967
        max = type(int256).max;

        //-57896044618658097711785492504343953926634992332820282019728792003956564819968
        min = type(int256).min;
    }
   
}
