// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.30;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TOK1 is ERC20 {
    constructor() ERC20("Token One", "TOK1") {}

    function deposit() public payable {
        _mint(msg.sender, msg.value * 2);
    }

    function withdraw(uint256 amount) public {
        _burn(msg.sender, amount);
        payable(msg.sender).transfer(amount / 2);
    }

    receive() external payable {
        deposit();
    }
}
