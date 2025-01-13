#!/usr/bin/env bash
set -eu

NETWORK="mangos-net"
IMAGE="mangos"
CONTAINER="mangos-mangosd"
SCRIPT_DIR="$(dirname "$(realpath "$0")")"

mkdir -p logs

docker run \
    --rm \
    --name "$CONTAINER" \
    --network "$NETWORK" \
    -p 8086:8086 \
    -v "$SCRIPT_DIR/generated":/data:ro \
    -v "$SCRIPT_DIR/logs":/logs \
    -v "$SCRIPT_DIR/mangosd.conf":/etc/mangosd.conf:ro \
    -it "$IMAGE" mangosd
