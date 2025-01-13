#!/usr/bin/env bash
set -euo pipefail

IMAGE="ghcr.io/pikdum/mangos_docker"
SCRIPT_DIR="$(dirname "$(realpath "$0")")"
OUTPUT_DIR="$(realpath "$SCRIPT_DIR/_generated/")"

echo "Using World of Warcraft at: $WOW_DIR"
echo "Generating files to: $OUTPUT_DIR"
mkdir -p "$OUTPUT_DIR"

docker run \
    --user "$(id -u):$(id -g)" \
    --rm \
    -v "$WOW_DIR":/input/ \
    -v "$OUTPUT_DIR":/output/ \
    -t "$IMAGE" map-extractor -- -i /input/ -o /output/

docker run \
    --user "$(id -u):$(id -g)" \
    --rm \
    -v "$WOW_DIR":/input/ \
    -v "$OUTPUT_DIR":/output/ \
    -w /output/ \
    -t "$IMAGE" vmap-extractor -i /input/ -s
