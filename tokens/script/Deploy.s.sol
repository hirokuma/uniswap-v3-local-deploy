// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.30;

import {Script} from "forge-std/Script.sol";

import {TOK1} from "../src/TOK1.sol";
import {TOK2} from "../src/TOK2.sol";

contract Deploy is Script {
    function run() public {
        vm.startBroadcast();

        new TOK1();
        new TOK2();

        vm.stopBroadcast();
    }
}
