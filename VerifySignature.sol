// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

/* Signature Verification

How to Sign and Verify
# Signing
1. Create message to sign
2. Hash the message
3. Sign the hash (off chain) // message is signed by the private key

# Signing Off Chain through metamask supported browser

1. Unlock MetaMask account
    ethereum.enable()

2. Get message hash to sign
    getMessageHash(
        0x5B38Da6a701c568545dCfcB03FcB875f56beddC4,
        500,
        "Thanks for landing on my Github",
        1
    )

    hash = "0xcf36ac4f97dc10d91fc2cbb20d718e94a8cbfe0f82eaedc6a4aa38946fb797cd"

3. Sign message hash 
    # using browser developer console
    account = "signer address here"
    ethereum.request({ method: "personal_sign", params: [account, hash]}).then(console.log)

    # using web3
    web3.personal.sign(hash, web3.eth.defaultAccount, console.log)

    Signature will be different for different accounts
    0x55ba47fac73e7f8b9b24ef7b433b698dee7b785d9a5e2ec93c096dd2dcde5933402e589589d1d171482fca8b0b7ab8fc64b74e8325cdd75327ee8c13de8e13391c


# Verify
1. Recreate hash from the original message
2. Recover signer from signature and hash
3. Compare recovered signer to claimed signer

 4. Verify signature
    signer = 0x90F8bf6A479f320ead074411a4B0e7944Ea8c9C1 // signer address
    to = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
    amount = 500
    message = "Thanks for landing on my Github"
    nonce = 1
    signature =
        0x55ba47fac73e7f8b9b24ef7b433b698dee7b785d9a5e2ec93c096dd2dcde5933402e589589d1d171482fca8b0b7ab8fc64b74e8325cdd75327ee8c13de8e13391c

*/

contract VerifySignature {
    // Generate keccak256 hash from digest(can consist of message string & other useful parameters )
    function getMessageHash(
        address _to,
        uint _amount,
        string memory _message,
        uint _nonce
    ) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_to, _amount, _message, _nonce));
    }

    
    function getEthSignedMessageHash(bytes32 _messageHash)
        internal
        pure
        returns (bytes32)
    {
        /*
        Signature is obtained by signing a keccak256 hash with the following format:
        "\x19Ethereum Signed Message\n" + length of _messageHash in string + _messageHash
        */
        return
            keccak256(
                abi.encodePacked("\x19Ethereum Signed Message:\n32", _messageHash)
            );
    }

    // Verifies if the signature is signed by the signer
    function verify(
        address _signer,
        address _to,
        uint _amount,
        string memory _message,
        uint _nonce,
        bytes memory signature
    ) public pure returns (bool) {
        bytes32 messageHash = getMessageHash(_to, _amount, _message, _nonce);
        bytes32 ethSignedMessageHash = getEthSignedMessageHash(messageHash);

        return recoverSigner(ethSignedMessageHash, signature) == _signer;
    }

    function recoverSigner(bytes32 _ethSignedMessageHash, bytes memory _signature)
        internal
        pure
        returns (address)
    {
        (uint8 v,bytes32 r, bytes32 s) = splitSignature(_signature);

        return ecrecover(_ethSignedMessageHash, v, r, s);
    }

    function splitSignature(bytes memory sig)
        internal
        pure
        returns (
            uint8 v,
            bytes32 r,
            bytes32 s
        )
    {
        require(sig.length == 65, "invalid signature length");

        assembly {
            /*
            First 32 bytes stores the length of the signature

            add(sig, 32) = pointer of sig + 32
            effectively, skips first 32 bytes of signature

            mload(p) loads next 32 bytes starting at the memory address p into memory
            */

            // first 32 bytes, after the length prefix
            r := mload(add(sig, 32))
            // second 32 bytes
            s := mload(add(sig, 64))
            // final byte (first byte of the next 32 bytes)
            v := byte(0, mload(add(sig, 96)))
        }
    }
}
