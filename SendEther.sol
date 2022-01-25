// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract EthReceiver {
    /*
    Which function is called, fallback() or receive()?

           send Ether
               |
         msg.data is empty?
              / \
            yes  no
            /     \
receive() exists?  fallback()
         /   \
        yes   no
        /      \
    receive()   fallback()
    */

    event Received(uint amountReceived, uint gasSpent);

    // Function to receive Ether. msg.data must be empty
    receive() external payable {
        emit Received(msg.value, gasleft());
    }

    // Fallback function is called when msg.data is not empty
    fallback() external payable {}

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

contract SendEther {

    // Error Handling: Send returns a boolean value indicating success or failure, thus need requires statement.
    // Gas Limit: sends 2300 gas(only enough for event emit), would fail if receive function perform more actions.
    // This function is not at all recommended for sending Ether
    function sendViaSend(address payable _to) public payable {
        bool sent = _to.send(msg.value);
        require(sent, "Failed to send Ether");
    }

    // Error Handling: Transfers throws exception if the transfer fails.
    // Gas Limit: sends 2300 gas(only enough for event emit), settable gas fees maybe in future
    // Though this is widely used but still it's not recommended for sending Ether due to limited gas limit
    function sendViaTransfer(address payable _to) public payable {
        _to.transfer(msg.value);
    }


    // Error Handling: Call returns a boolean value indicating success or failure, thus need requires statement.
    // Gas Limit: forward all gas by defaut or also can send by setting gas
    // Note: This function in combination with re-entrancy guard should be used by asssuring :
                        //          . making all state changes before calling other contracts
                        //          . using re-entrancy guard modifier to prevent re-entrancy
    function sendViaCall(address payable _to) public payable {
        (bool sent, bytes memory data) = _to.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }

    function sendViaCallCustomGas(address payable _to, uint _gas) public payable {
        (bool sent, bytes memory data) = _to.call{value: msg.value, gas: _gas}("");
        require(sent, "Failed to send Ether");
    }
}
