// SPDX-License-Identifier: UNLICENSED
pragma solidity =0.7.6;

interface Vm {
    function startBroadcast() external;
    function stopBroadcast() external;
    function envAddress(string calldata key) external view returns (address);
}

import {INonfungiblePositionManager} from '@uniswap/v3-periphery/contracts/interfaces/INonfungiblePositionManager.sol';

import {LiquidityExamples} from "../src/lp_example.sol";

contract Deploy {
    Vm constant vm = Vm(address(uint160(uint256(keccak256("hevm cheat code")))));
    address constant nonfungiblePositionManager = 0x5FC8d32690cc91D4c39d9d3abcBD16989F875707;

    function run() external {
        vm.startBroadcast();

        INonfungiblePositionManager nfpm = INonfungiblePositionManager(nonfungiblePositionManager);
        address addr1 = vm.envAddress("TOK1");
        address addr2 = vm.envAddress("TOK2");
        new LiquidityExamples(nfpm, addr1, addr2);

        vm.stopBroadcast();
    }
}
