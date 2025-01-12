#!/usr/bin/env bash
set -eu

IMAGE="mangos"
CONTAINER="mangos-realmd"
SCRIPT_DIR="$(dirname "$(realpath "$0")")"

docker run \
    --rm \
    --name "$CONTAINER" \
    --net=host \
    -v "$SCRIPT_DIR/realmd.conf":/etc/realmd.conf:ro \
    -t "$IMAGE" realmd
