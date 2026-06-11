#!/bin/bash

source ./.env
source ./.env-addrs

function balance() {
    val=$(cast balance $ADDR)
    echo "native: $val"
    val=$(cast call $WETH9 "balanceOf(address)" $ADDR | cast to-dec)
    echo "WETH9: $val"
    val=$(cast call $TOK1 "balanceOf(address)" $ADDR | cast to-dec)
    echo "TOK1: $val"
    val=$(cast call $TOK2 "balanceOf(address)" $ADDR | cast to-dec)
    echo "TOK2: $val"
}

balance

echo "Approve SwapExmaple to transfer User's DAI"
res=$(cast send $TOK1 "approve(address,uint256)" $SWAPEXAMPLES 1ether --private-key $PRIVKEY --rpc-url $RPC_URL)
cnt=$(echo $res | grep -c "(failed)" || true)
if [[ $cnt -ne 0 ]]; then
    echo "Error happened:"
    echo "$res"
    echo "EXIT by ERROR"
    exit 1
fi

echo "Swap: User=WETH9 <--> DAI"
res=$(cast send $SWAPEXAMPLES "swapExactInputSingle(uint256)" 10wei --from $ADDR --gas-limit 300000 --private-key $PRIVKEY --rpc-url $RPC_URL)
cnt=$(echo $res | grep -c "(failed)" || true)
if [[ $cnt -ne 0 ]]; then
    echo "Error happened:"
    echo "$res"
    echo "EXIT by ERROR"
    exit 1
fi

sleep 2

balance
