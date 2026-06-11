#!/bin/bash -ue

DEPROY_DIR=deployment

source ./.env

pushd $DEPROY_DIR
forge script ./script/Calc.s.sol --rpc-url $RPC_URL --private-key $PRIVKEY
popd
