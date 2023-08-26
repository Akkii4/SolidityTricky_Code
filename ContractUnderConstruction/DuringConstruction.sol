// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.0;

// Showing possibility of contract calls from the constructor interaction while its  being constructed
contract DuringConstruction {
    event amountReceived(bool);

    receive() external payable {
        emit amountReceived(true);
    }

    uint256 public receivedEther;

    constructor(ExternalContract _extContract) payable {
        // Receiving Ether : contract address is created even before start of init code such that it can accepts the ether sent along with constructor call
        receivedEther += msg.value;
        // but fallback or receive functions CANNOT be called while it is being constructed
        _extContract.sendValToContract{value: msg.value}(this);

        // Calling public/internal function of own contract
        require(testPublic(), "Public function not called");

        // External function of a contract CANNOT be called while it is being constructed
        require(!this.testExternal());
        require(!_extContract.callOtherContract(this)); // Neither External contract can call external function
    }

    function testPublic() public pure returns (bool) {
        return true;
    }

    function testExternal() external pure returns (bool) {
        return true;
    }
}

contract ExternalContract {
    function callOtherContract(
        DuringConstruction _contract
    ) external pure returns (bool) {
        return _contract.testExternal();
    }

    function sendValToContract(DuringConstruction _contract) external payable {
        (bool success, ) = address(_contract).call{value: msg.value}("");
        require(success);
    }
}
