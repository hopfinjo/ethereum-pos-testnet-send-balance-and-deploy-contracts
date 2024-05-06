#!/bin/bash

set -exu
set -o pipefail

# Check if jq is installed
if ! command -v jq &> /dev/null; then
    echo "Error: jq is not installed. Please install jq first."
    exit 1
fi

# including logs and storage
NETWORK_DIR=./network

# Change this number for your desired number of nodes
NUM_NODES=2


cleanup() {
    echo "Caught Ctrl+C. Killing active background processes and exiting."
    kill $(jobs -p)  # Kills all background processes started in this script
    exit
}
# Trap the SIGINT signal and call the cleanup function when it's caught
trap 'cleanup' SIGINT

# Reset the data from any previous runs and kill any hanging runtimes
rm -rf "$NETWORK_DIR" || echo "no network directory"
mkdir -p $NETWORK_DIR
pkill geth || echo "No existing geth processes"
pkill beacon-chain || echo "No existing beacon-chain processes"
pkill validator || echo "No existing validator processes"
pkill bootnode || echo "No existing bootnode processes"

# Set Paths for your binaries. Configure as you wish, particularly
# if you're developing on a local fork of geth/prysm
GETH_BINARY=./dependencies/go-ethereum/build/bin/geth


# Create the validators in a loop
for (( i=0; i<$NUM_NODES; i++ )); do
    NODE_DIR=$NETWORK_DIR/node-$i
    mkdir -p $NODE_DIR/execution

    # We use "1234" as pw, do not use this in production
    geth_pw_file="1234"
    echo "" > "$geth_pw_file"

    # Create the secret keys for this node and other account details
    $GETH_BINARY account new --datadir "$NODE_DIR/execution" --password "$geth_pw_file"

done


