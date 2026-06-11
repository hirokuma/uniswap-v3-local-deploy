#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
echo $SCRIPT_DIR

source $SCRIPT_DIR/deploy-dirs

for dir in "${DIRS[@]}"; do
    pushd $dir
    forge build
    popd
done
