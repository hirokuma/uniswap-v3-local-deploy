// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.6;

import "forge-std/Script.sol";
import "@uniswap/v3-core/contracts/UniswapV3Pool.sol";

contract GetPoolInitCodeHash is Script {
    function run() public view {
        bytes32 initCodeHash = keccak256(type(UniswapV3Pool).creationCode);
        
        console.log("POOL_INIT_CODE_HASH");
        console.logBytes32(initCodeHash);
    }
}