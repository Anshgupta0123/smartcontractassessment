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
