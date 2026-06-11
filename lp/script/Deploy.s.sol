// SPDX-License-Identifier: UNLICENSED
pragma solidity =0.7.6;

interface Vm {
    function startBroadcast() external;
    function stopBroadcast() external;
    function envAddress(string calldata key) external view returns (address);
}

import {INonfungiblePositionManager} from '@uniswap/v3-periphery/contracts/interfaces/INonfungiblePositionManager.sol';
// import {IUniswapV3Pool} from '@uniswap/v3-core/contracts/interfaces/IUniswapV3Pool.sol';

import {LiquidityDaiWeth} from "../src/lp_dai_weth.sol";
import {LiquidityExamples} from "../src/lp_dai_usdc.sol";

contract Deploy {
    Vm constant vm = Vm(address(uint160(uint256(keccak256("hevm cheat code")))));

    function run() external {
        vm.startBroadcast();

        address nonfungiblePositionManager = vm.envAddress("NONFUNGIBLEPOSITIONMANAGER");

        address weth9 = vm.envAddress("WETH9");
        address addr1 = vm.envAddress("TOK1");
        address addr2 = vm.envAddress("TOK2");

        INonfungiblePositionManager nfpm = INonfungiblePositionManager(nonfungiblePositionManager);
        new LiquidityDaiWeth(nfpm, addr1, weth9);
        new LiquidityExamples(nfpm, addr1, addr2);

        vm.stopBroadcast();
    }
}
