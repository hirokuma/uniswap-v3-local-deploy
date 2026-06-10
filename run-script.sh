#!/bin/bash -ue

if [[ $# -eq 0 || $# gt 2 ]]; then
    echo "Bad parameter:"
    echo "   $0 <DEPLOY_DIR> [clean]"
    exit 1
fi

DEPROY_DIR=$1

if [[ $# -eq 2 && "$2" == "clean" ]]; then
    forge clean
fi

source ./.env

pushd $DEPROY_DIR
forge script ./script/Deploy.s.sol --rpc-url $RPC_URL --private-key $PRIVKEY --broadcast
popd
