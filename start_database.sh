#!/usr/bin/env bash
set -eu

NETWORK="mangos-net"
DB_CONTAINER="mangos-mariadb"
DB_PASSWORD="mangos"
SCRIPT_DIR="$(dirname "$(realpath "$0")")"
INSTALL_FILE="$SCRIPT_DIR/install-databases.exp"

docker stop "$DB_CONTAINER" || true
docker network rm "$NETWORK" || true

docker network create \
    --driver bridge \
    $NETWORK

docker run \
    --rm \
    -d \
    --name "$DB_CONTAINER" \
    -e MARIADB_ROOT_PASSWORD="$DB_PASSWORD" \
    --network "$NETWORK" \
    -t mariadb:latest

echo "Waiting for mariadb..."
until docker exec "$DB_CONTAINER" mariadb -uroot -p"$DB_PASSWORD" -e "SELECT 1" &>/dev/null; do
    sleep 1
done

docker run \
    --rm \
    -v "$INSTALL_FILE:/install-databases.exp:ro" \
    -e DB_CONTAINER="$DB_CONTAINER" \
    -e DB_PASSWORD="$DB_PASSWORD" \
    --network "$NETWORK" \
    -i ubuntu:24.04 bash <<"EOF"
echo "Installing dependencies..."
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y git expect mariadb-client

echo "Installing latest mangoszero/database..."
git clone https://github.com/mangoszero/database.git
cd database/
git submodule update --init
cp /install-databases.exp .
./install-databases.exp

mariadb -h "$DB_CONTAINER" -uroot -p"$DB_PASSWORD" -D realmd  -e "UPDATE realmlist SET port=8086;"

EOF
