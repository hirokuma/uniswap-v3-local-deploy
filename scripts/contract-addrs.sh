#!/bin/bash -eu

function get_contract_addr() {
    DEPROY_DIR=$1
    cat $DEPROY_DIR/broadcast/Deploy.s.sol/31337/run-latest.json | jq -r '.transactions[] | select(.contractName != "") | {name: .contractName, address: .contractAddress}'
}

get_contract_addr deployment
get_contract_addr tokens
get_contract_addr lp
