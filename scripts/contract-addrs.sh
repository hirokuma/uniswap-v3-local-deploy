#!/bin/bash -eu

function get_contract_addr() {
    DEPROY_DIR=$1

    if [[ ! -f $DEPROY_DIR/broadcast/Deploy.s.sol/31337/run-latest.json ]]; then
        echo "Not found: $DEPROY_DIR/broadcast/Deploy.s.sol/31337/run-latest.json"
        exit 1
    fi
    cat $DEPROY_DIR/broadcast/Deploy.s.sol/31337/run-latest.json | jq -r '.transactions[] | select(.contractName != "") | {name: .contractName, address: .contractAddress}'
}

get_contract_addr deployment > .env-addrs
get_contract_addr tokens >> .env-addrs
get_contract_addr lp >> .env-addrs

ADDRS=`cat .env-addrs`
echo $ADDRS | jq -rs '(.[] | "\(.name | ascii_upcase)=\(.address)")' > .env-addrs
