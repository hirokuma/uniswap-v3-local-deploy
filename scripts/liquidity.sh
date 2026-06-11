#!/bin/bash

source ./.env
source ./.env-addrs

function send_check() {
    res="$1"
    cnt=$(echo $res | grep -c "(failed)" || true)
    if [[ $cnt -ne 0 ]]; then
        echo "Error happened:"
        echo "$res"
        echo "EXIT by ERROR"
        exit 1
    fi
}

echo "Approve LiquidityDaiWeth to transfer User's DAI"
res=$(cast send $TOK1 "approve(address,uint256)" $LIQUIDITYDAIWETH 1ether --private-key $PRIVKEY --rpc-url $RPC_URL)
send_check "$res"

echo "Approve LiquidityDaiWeth to transfer User's WETH9"
res=$(cast send $WETH9 "approve(address,uint256)" $LIQUIDITYDAIWETH 1ether --private-key $PRIVKEY --rpc-url $RPC_URL)
send_check "$res"

echo "Mint DAI/WETH9 Liquidity"
GAS=10000000
res=$(cast send $LIQUIDITYDAIWETH "mintNewPosition()" --from $ADDR --gas-limit $GAS --private-key $PRIVKEY --rpc-url $RPC_URL)
send_check "$res"
