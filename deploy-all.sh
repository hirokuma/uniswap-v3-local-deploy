#!/bin/bash -e

DEPLOY_SCRIPT="./run-script.sh"

$DEPLOY_SCRIPT deployment $1
$DEPLOY_SCRIPT tokens $1
$DEPLOY_SCRIPT lp $1
