#!/usr/bin/env bash
set -eu

NETWORK="mangos-net"
IMAGE="mangos"
CONTAINER="mangos-mangosd"
SCRIPT_DIR="$(dirname "$(realpath "$0")")"

mkdir -p logs

docker run \
    --user "$(id -u):$(id -g)" \
    --rm \
    --name "$CONTAINER" \
    --network "$NETWORK" \
    -p 8086:8086 \
    -v "$SCRIPT_DIR/../_generated":/data:ro \
    -v "$SCRIPT_DIR/../logs":/logs \
    -v "$SCRIPT_DIR/../conf/mangosd.conf":/etc/mangosd.conf:ro \
    -it "$IMAGE" mangosd
