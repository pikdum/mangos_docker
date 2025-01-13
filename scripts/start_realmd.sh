#!/usr/bin/env bash
set -eu

NETWORK="mangos-net"
IMAGE="ghcr.io/pikdum/mangos_docker"
CONTAINER="mangos-realmd"
SCRIPT_DIR="$(dirname "$(realpath "$0")")"
CONF_FILE="$SCRIPT_DIR/../conf/realmd.conf"

docker run \
    --user "$(id -u):$(id -g)" \
    --rm \
    -d \
    --name "$CONTAINER" \
    --network "$NETWORK" \
    -p 3725:3725 \
    -v "$CONF_FILE":/etc/realmd.conf:ro \
    -t "$IMAGE" realmd
