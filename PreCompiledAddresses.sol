// Ethereum has precompiled (built-in) contracts implemented as core functionality of EVM and are used to perform specific functions , these precompiles live in addresses 0x01 to 0x09

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PrecompiledFunctions {

    // Address 0x01 ecRecover :- recovers signer's address from the valid signature and hash
    function recoverSignature(bytes32 hash, uint8 v, bytes32 r, bytes32 s) public pure returns (address recoveredAddress) {
        recoveredAddress = ecrecover(hash, v, r, s);
        require(recoveredAddress != address(0), "Signature is invalid");
    }

    // Address 0x02 SHA-256 :- generates SHA-256 hash for the input
    function hashSHA256(uint256 numberToHash) public view returns (bytes32 h) {
		(bool ok, bytes memory out) = address(2).staticcall(abi.encode(numberToHash));
		require(ok);
		h = abi.decode(out, (bytes32));
    }

    // Address 0x03 RIPEMD-160 :- generates RIPEMD-160 hash of the input
    function hashRIPEMD160(bytes calldata data) public view returns (bytes20 h) {
        (bool ok, bytes memory out) = address(3).staticcall(data);
        require(ok);
        h = bytes20(abi.decode(out, (bytes32)) << 96);
    }

    // Address 0x04 Identity :- allow Copy of one region continous memory set of 32 byte words in one go to another memory slot, instead of one byte at a time
    function identity(bytes32 sourceLocation, bytes32 destinationLocation, uint256 length) public view {
        assembly {
            if iszero(staticcall(not(0), 0x04, add(sourceLocation, 32), length, add(destinationLocation, 32), length)) {
                revert(0, 0)
            }
        }
    }

    // Address 0x05 Modexp :- Used for modular exponentiation, that involves raising a number to a power, and then taking the result modulo some other number.
    function modexp(bytes32 base) public view returns (bytes32 result) {
        assembly {
            if iszero(staticcall(not(0), 0x05, add(0x20, base), 96, add(0x20, result), 32)) {
                revert(0, 0)
            }
        }
    }

    // Address 0x06 ecAdd :- Elliptic Curve Addition
    function ecAdd(bytes memory inputs) public view returns (bytes32 result) {
        assembly {
            if iszero(staticcall(not(0), 0x06, add(inputs, 32), mload(inputs), add(0x20, result), 32)) {
                revert(0, 0)
            }
        }
    }
    // Address 0x07 ecMul :- Elliptic Curve Multiplication
    function ecMul(bytes memory inputs) public view returns (bytes32 result) {
        assembly {
            if iszero(staticcall(not(0), 0x07, add(inputs, 32), mload(inputs), add(0x20, result), 32)) {
                revert(0, 0)
            }
        }
    }

    // Address 0x08 ecAdd :- Elliptic Curve Pairing
    function ecPairing(bytes memory inputs) public view returns (bool result) {
        assembly {
            if iszero(staticcall(not(0), 0x08, add(inputs, 32), mload(inputs), add(0x20, result), 1)) {
                revert(0, 0)
            }
        }
    }

    // Address 0x09 Blake2 :- Cryptographic hashing for the allowing interoperability between the EVM and Zcash
    function blake2b(bytes memory data) public view returns (bytes32) {
        bytes32 hash;
        assembly {
            if iszero(staticcall(not(0), 0x09, add(data, 32), 0xd5, hash, 0x40)) {
            revert(0, 0)
            }
        }
        return hash;
    }
}
