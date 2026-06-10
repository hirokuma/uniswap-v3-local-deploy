#!/bin/bash -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

DEPLOY_SCRIPT="$SCRIPT_DIR/run-script.sh"

source $SCRIPT_DIR/deploy-dirs

for dir in "${DIRS[@]}"; do
    $DEPLOY_SCRIPT $dir $1
done
