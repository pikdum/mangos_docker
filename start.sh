#!/usr/bin/env bash

SCRIPT_DIR="$(dirname "$(realpath "$0")")"

docker start mangos-mariadb || true
"$SCRIPT_DIR/scripts/start_realmd.sh"
trap "docker stop mangos-realmd" EXIT

"$SCRIPT_DIR/scripts/start_mangosd.sh"
