#!/bin/bash

source ./.env
source ./.env-addrs

function balance() {
    val=$(cast call $WETH9 "balanceOf(address)" $ADDR | cast to-dec)
    echo "WETH9: $val"
    val=$(cast call $TOK1 "balanceOf(address)" $ADDR | cast to-dec)
    echo "TOK1: $val"
    val=$(cast call $TOK2 "balanceOf(address)" $ADDR | cast to-dec)
    echo "TOK2: $val"
}

cast send $WETH9 "deposit()" --value 10ether --private-key $PRIVKEY --rpc-url $RPC_URL
cast send $TOK1 "deposit()" --value 1ether --private-key $PRIVKEY --rpc-url $RPC_URL
cast send $TOK2 "deposit()" --value 1ether --private-key $PRIVKEY --rpc-url $RPC_URL

balance
