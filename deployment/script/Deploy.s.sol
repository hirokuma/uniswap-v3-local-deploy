// SPDX-License-Identifier: UNLICENSED
pragma solidity =0.7.6;

interface Vm {
    function startBroadcast() external;
    function stopBroadcast() external;
}

import {UniswapV3Factory} from "@uniswap/v3-core/contracts/UniswapV3Factory.sol";
import {SwapRouter} from "@uniswap/v3-periphery/contracts/SwapRouter.sol";
import "@uniswap/v3-periphery/contracts/libraries/NFTDescriptor.sol";
import {NonfungiblePositionManager} from "@uniswap/v3-periphery/contracts/NonfungiblePositionManager.sol";
import {
    NonfungibleTokenPositionDescriptor
} from "@uniswap/v3-periphery/contracts/NonfungibleTokenPositionDescriptor.sol";
// import {Quoter} from "@uniswap/v3-periphery/contracts/lens/Quoter.sol";

import {WETH9} from "../src/WETH9.sol";

contract Deploy {
    Vm constant vm = Vm(address(uint160(uint256(keccak256("hevm cheat code")))));

    // A null-terminated string for native token('ATH')
    bytes32 constant nativeCurrencyLabel = 0x4154480000000000000000000000000000000000000000000000000000000000;

    function run() external {
        vm.startBroadcast();

        UniswapV3Factory factory = new UniswapV3Factory();
        WETH9 weth9 = new WETH9();

        // swap
        new SwapRouter(address(factory), address(weth9));

        // liquidity
        NonfungibleTokenPositionDescriptor desc = new NonfungibleTokenPositionDescriptor(
            address(weth9), nativeCurrencyLabel
        );
        new NonfungiblePositionManager(address(factory), address(weth9), address(desc));

        vm.stopBroadcast();
    }
}
