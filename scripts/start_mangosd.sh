#!/usr/bin/env bash
set -eu

NETWORK="mangos-net"
IMAGE="ghcr.io/pikdum/mangos_docker"
CONTAINER="mangos-mangosd"
SCRIPT_DIR="$(dirname "$(realpath "$0")")"
GENERATED_DIR="$SCRIPT_DIR/../_generated"
LOG_DIR="$SCRIPT_DIR/../_logs"
CONF_FILE="$SCRIPT_DIR/../conf/mangosd.conf"

mkdir -p "$LOG_DIR"

docker run \
    --user "$(id -u):$(id -g)" \
    --rm \
    --name "$CONTAINER" \
    --network "$NETWORK" \
    -p 8086:8086 \
    -v "$GENERATED_DIR":/data:ro \
    -v "$LOG_DIR":/logs \
    -v "$CONF_FILE":/etc/mangosd.conf:ro \
    -it "$IMAGE" mangosd
