// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ChristineToken is ERC20 {
    address private owner;

    // Constructor to set the token name, symbol, and initial supply
    constructor(string memory name, string memory symbol, uint256 initialSupply) ERC20(name, symbol) {
        _mint(msg.sender, initialSupply); // Mint initial supply to deployer
        owner = msg.sender; // Set deployer as owner
    }

    // Modifier to restrict access to owner-only functions
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can control this function");
        _;
    }

    // Function to mint new tokens, only callable by the owner
    function mint(address account, uint256 amount) public onlyOwner {
        _mint(account, amount);
    }

    // Function to burn tokens, callable by any token holder
    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    // Override transfer function to prevent transfers to the zero address
    function transfer(address recipient, uint256 amount) public override returns (bool) {
        require(recipient != address(0), "ERC20: transfer to the zero address");
        _transfer(_msgSender(), recipient, amount); // Use _msgSender() instead of msg.sender
        return true;
    }

    // Override transferFrom function to prevent transfers to the zero address
    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        require(recipient != address(0), "ERC20: transfer to the zero address");
        _transfer(sender, recipient, amount);
        _approve(sender, _msgSender(), allowance(sender, _msgSender()) - amount); // Use _msgSender() instead of msg.sender
        return true;
    }
}
