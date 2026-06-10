#!/bin/bash -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

DEPLOY_SCRIPT="$SCRIPT_DIR/run-script.sh"

source $SCRIPT_DIR/deploy-dirs

rm -f .env-addrs
touch .env-addrs
for dir in "${DIRS[@]}"; do
    source .env-addrs
    $DEPLOY_SCRIPT $dir $1

    addrs=$(cat $dir/broadcast/Deploy.s.sol/31337/run-latest.json | jq -r '.transactions[] | select(.contractName != "") | {name: .contractName, address: .contractAddress}')
    echo $addrs | jq -rs '(.[] | "export \(.name | ascii_upcase)=\(.address)")' >> .env-addrs
done
