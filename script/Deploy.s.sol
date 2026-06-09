// SPDX-License-Identifier: UNLICENSED 
pragma solidity =0.7.6;

interface Vm {
    function startBroadcast() external;
    function stopBroadcast() external;
}

import {UniswapV3Factory} from "@uniswap/v3-core/contracts/UniswapV3Factory.sol";
import {SwapRouter} from "@uniswap/v3-periphery/contracts/SwapRouter.sol";

import {WETH9} from "../src/WETH9.sol";

contract Deploy {
    Vm constant vm =
        Vm(address(uint160(uint256(keccak256("hevm cheat code")))));

    function run() external {
        vm.startBroadcast();

        UniswapV3Factory factory = new UniswapV3Factory();
        WETH9 weth9 = new WETH9();
        new SwapRouter(address(factory), address(weth9));

        vm.stopBroadcast();
    }
}
