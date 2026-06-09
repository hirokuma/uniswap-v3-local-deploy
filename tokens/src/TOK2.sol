// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.30;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TOK2 is ERC20 {
    constructor() ERC20("Token Two", "TOK2") {}

    function deposit() public payable {
        _mint(msg.sender, msg.value * 3);
    }

    function withdraw(uint256 amount) public {
        _burn(msg.sender, amount);
        payable(msg.sender).transfer(amount / 3);
    }

    receive() external payable {
        deposit();
    }
}
