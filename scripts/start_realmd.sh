#!/usr/bin/env bash
set -eu

NETWORK="mangos-net"
IMAGE="mangos"
CONTAINER="mangos-realmd"
SCRIPT_DIR="$(dirname "$(realpath "$0")")"

docker run \
    --user "$(id -u):$(id -g)" \
    --rm \
    -d \
    --name "$CONTAINER" \
    --network "$NETWORK" \
    -p 3725:3725 \
    -v "$SCRIPT_DIR/../conf/realmd.conf":/etc/realmd.conf:ro \
    -t "$IMAGE" realmd
