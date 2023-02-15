pragma solidity 0.8.0;

   /* You shouldn't rely on `isContract` to protect against flash loan attacks!
    *
    * Preventing calls from contracts is highly discouraged. It breaks composability, breaks support for smart wallets
    * like Gnosis Safe, and does not provide security since it can be circumvented by calling from a contract
    * constructor.
    * ====
    */
contract CodeSize {

    function isContract_new(address account) public view returns (bool) {
        // This method relies on extcodesize/address.code.length, which returns 0
        // for contracts in construction, since the code is only stored at the end
        // of the constructor execution.
        return account.code.length > 0;
    }

    function isContract_old(address _addr) public view returns (bool){
        uint256 size;
        // retrieve the size of the code, this needs assembly
        assembly {
            size := extcodesize(_addr)
        }
        return (size > 0);
    }
    
    /* EVM opcode EXTCODEHASH returns the hash of the bytecode contract 
        - use to determine if an address is a smart contract 
        - can detect even smaller changes in the contract code
        - all Externally Owned Account address will return the following hash & 0x0 for any unused account
    */
    function isContract_OP(address account) external view returns (bool) {
        bytes32 eoaHash = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;

        bytes32 codeHash;    
        assembly { codeHash := extcodehash(account) }

        return (codeHash != eoaHash && codeHash != 0x0);
   }

}
