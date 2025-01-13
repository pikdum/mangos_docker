#!/usr/bin/env bash
set -eu

NETWORK="mangos-net"
IMAGE="mangos"
CONTAINER="mangos-realmd"
SCRIPT_DIR="$(dirname "$(realpath "$0")")"

docker run \
    --rm \
    --name "$CONTAINER" \
    --network "$NETWORK" \
    -p 3725:3725 \
    -v "$SCRIPT_DIR/realmd.conf":/etc/realmd.conf:ro \
    -t "$IMAGE" realmd
