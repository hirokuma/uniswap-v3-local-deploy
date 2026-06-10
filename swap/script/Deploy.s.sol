// SPDX-License-Identifier: UNLICENSED
pragma solidity =0.7.6;

interface Vm {
    function startBroadcast() external;
    function stopBroadcast() external;
    function envAddress(string calldata key) external view returns (address);
}

import {ISwapRouter} from '@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol';

import {SwapExamples} from "../src/swap_example.sol";

contract Deploy {
    Vm constant vm = Vm(address(uint160(uint256(keccak256("hevm cheat code")))));

    function run() external {
        vm.startBroadcast();

        address swapRouter = vm.envAddress("SWAPROUTER");
        address weth9 = vm.envAddress("WETH9");
        address addr1 = vm.envAddress("TOK1");
        address addr2 = vm.envAddress("TOK2");

        ISwapRouter sr = ISwapRouter(swapRouter);
        new SwapExamples(sr, weth9, addr1, addr2);

        vm.stopBroadcast();
    }
}
