AssessmentContract
This Solidity contract demonstrates the implementation of a simple Ethereum smart contract that allows users to deposit and withdraw Ether, and provides owner-only functionality for restricted actions.

Description
The AssessmentContract is designed to handle basic deposit and withdrawal functions with event logging for transparency. It also includes features to manage contract ownership and perform owner-restricted actions.

Contract Features
Deposits: Users can deposit Ether into the contract, which will be tracked in their balance.
Withdrawals: Users can withdraw Ether from their balance.
Ownership Transfer: The contract owner can transfer ownership to a new owner.
Restricted Actions: Certain functions can only be performed by the contract owner.
Event Logging: Deposit and withdrawal actions are logged through events.
Getting Started
To interact with this contract, you can use Remix, an online Solidity IDE.

Prerequisites
Ensure you have access to the Remix IDE.
Steps to Deploy and Interact with the Contract
Create a New File:

In Remix, click on the "+" icon in the left-hand sidebar.
Save the file with a .sol extension (e.g., AssessmentContract.sol).
Copy and Paste the Code:

Copy and paste the provided Solidity code into the file:
solidity
Copy code


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AssessmentContract {
    address public owner;
    mapping(address => uint) public balances;
    event Deposit(address indexed account, uint amount);
    event Withdrawal(address indexed account, uint amount);
    constructor() {
        owner = msg.sender;
    }
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can do this");
        _;
    }
    function deposit() public payable {
        require(msg.value > 0, "Must send some ether");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }
    function withdraw(uint _amount) public {
        require(_amount > 0, "Must withdraw some ether");
        require(balances[msg.sender] >= _amount, "Not enough balance");
        balances[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);
        emit Withdrawal(msg.sender, _amount);
    }
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "New owner cannot be zero address");
        owner = newOwner;
    }
    function restrictedAction() public view onlyOwner {
        assert(msg.sender == owner);
        // Do something only the owner can do
    }
    function revertExample() public pure {
        bool someCondition = false;
        if (!someCondition) {
            revert("This is an example of revert");
        }
    }
}

Compile the Contract:

Click on the "Solidity Compiler" tab in the left-hand sidebar.
Ensure the "Compiler" option is set to a compatible version (e.g., 0.8.0).
Click on the "Compile AssessmentContract.sol" button.
Deploy the Contract:

Click on the "Deploy & Run Transactions" tab in the left-hand sidebar.
Select the AssessmentContract from the dropdown menu.
Click on the "Deploy" button.
Interact with the Contract:

After deployment, the contract will appear under "Deployed Contracts".
You can interact with the contract functions (deposit, withdraw, transferOwnership, etc.) by entering necessary parameters and clicking the corresponding buttons.
Example Interactions
Deposit Ether:
Enter an amount of Ether in the "Value" field.
Click on the deposit button to add Ether to your balance.
Withdraw Ether:
Enter the amount you want to withdraw in the _amount field.
Click on the withdraw button to withdraw Ether from your balance.
Transfer Ownership:
Enter the new owner's address in the newOwner field.
Click on the transferOwnership button to change the contract owner.
Conclusion
This Solidity contract provides a basic framework for managing deposits, withdrawals, and ownership within a smart contract
