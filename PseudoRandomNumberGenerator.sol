// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract PseudoRandomNumberGenerator {
    // @notice Generates a pseudo-random number with parameters that is hard for one entity to
    /// reasonably control.
    /// @param _salt A salt hashed as part of the pseudo-random generation.
    /// @return A pseudo-random uint256.
    function generateRandomNumber(uint256 _salt) public view returns (uint256) {
        return uint256(
            keccak256(
                abi.encodePacked(
                    msg.sender,
                    tx.gasprice,
                    block.number,
                    block.timestamp,
                    block.difficulty,
                    _salt
                )
            )
        );
    }

    // Generates random number less than within 0 & range
    function randomNumberInRange(uint _range) public view returns (uint){
        return generateRandomNumber(block.number) % _range;
    }

}