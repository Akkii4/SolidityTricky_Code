// SPDX-License-Identifier: UNLICENSED

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

}
