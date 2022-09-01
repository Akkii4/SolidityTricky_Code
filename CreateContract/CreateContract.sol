// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./Test.sol";

contract CreateContract {
    event CreatedNew(address _contractAddress);
    event Create(address _contractAddress);
    event Create2(address _contractAddress);

    // 1. Create contract by new keyword
    function createByNew() external payable {
        Test t = new Test{value: msg.value}(100);
        emit CreatedNew(address(t));
    }

    // Get creation bytecode of the contract
    function getBytecode(uint256 _testVar) public pure returns (bytes memory) {
        bytes memory code = type(Test).creationCode;
        return abi.encodePacked(code, abi.encode(_testVar)); // encode the bytecode with the constructor parameter
    }

    // useful to determine any changes to the contract's bytecode caused due to change in the contract
    function bytecodeHash() external pure returns (bytes32) {
        return keccak256(type(Test).creationCode);
    }

    // 2. Create contract by create method
    function createBytecode(bytes memory bytecode) external payable {
        address addr;
        assembly {
            // create(v, p, n)
            // v= amount of ETH to send
            // p = pointer in memory to start of code, (0x20 is 32 in hex)
            // n = size of code
            addr := create(
                callvalue(), // wei value sending as part of the call
                add(bytecode, 0x20), // add 32 bytes to start of code, as first 32 bytes are length of code
                mload(bytecode) // size of code stored in first 32 bytes
            )
        }
        require(addr != address(0), "creation failed");
        emit Create(addr);
    }

    //   Compute the address of the contract to be deployed through create2 method
    //   keccak256(0xff + deployer address + salt + keccak256 (creation code))
    //   take last 20 bytes
    function preComputeCreate2Address(bytes memory bytecode, uint256 _salt)
        public
        view
        returns (address)
    {
        bytes32 hash = keccak256(
            abi.encodePacked(
                bytes1(0xff),
                address(this),
                _salt,
                keccak256(bytecode)
            )
        );
        return address(uint160(uint256(hash)));
    }

    // 3. Create contract by create2 method
    function create2Bytecode(bytes memory bytecode, uint256 _salt)
        external
        payable
    {
        address addr;
        assembly {
            // create(v, p, n, s)
            // v= amount of ETH to send
            // p = pointer in memory to start of code
            // n = size of code
            // s = salt (any arbitrary value for randomness)
            addr := create2(
                callvalue(), // wei sent with current call
                add(bytecode, 32), // Actual code starts after skipping the first 32 bytes
                mload(bytecode), // load the size of code
                _salt // salt
            )

            if iszero(extcodesize(addr)) {
                // if contract size is empty, revert
                revert(0, 0)
            }
        }
        emit Create2(addr);
    }
}
