// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract BlocksInfo {
    // Returns the time at the block creation (in seconds since the epoch)
    function getCurrentTime() public view returns (uint) {
        return block.timestamp;
    }

    // Returns the chain ID of the blockchain, To ensure the desired blockchain & not a forked.
    function getChainID() public view returns (uint) {
        return block.chainid;
    }

    // Returns current block miner address.
    function getBlockMiner() public view returns (address) {
        return block.coinbase;
    }

    // Returns current block gas limit(maximum amount of gas that can be used in this block).
    // Might protect against out of gas attacks, or running infinite gas operations.
    function getBlockGasLimit() public view returns (uint) {
        return block.gaslimit;
    }

    // Returns the block number of the block that contains the given transaction.
    function getBlockNumber() public view returns (uint) {
        return block.number;
    }

    // Returns the current difficulty used while mining the blocj
    function getBlockDifficulty() public view returns (uint) {
        return block.difficulty;
    }

    // Return the hash of recent 256 blocks, otherwise returns 0
    function getBlockHash(uint blockNumber) public view returns (bytes32) {
        return blockhash(blockNumber);
    }

    // Return the gas left in the current Transaction/Contract
    function getGasLeft() public view returns (uint) {
        return gasleft();
    }

    // Return block's base fee recently introduced after EIP-1559(London Fork)
    // Should only be used EVM version >= london
    function getBaseFee() public view returns (uint) {
        return block.basefee;
    }

    // Return the gas price of the transaction
    function getTrxGasPrice() public view returns (uint) {
        return tx.gasprice;
    }

}