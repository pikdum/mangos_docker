#!/usr/bin/env bash
set -eu

DB_CONTAINER="mangos-mariadb"
DB_PASSWORD="mangos"
SCRIPT_DIR="$(dirname "$(realpath "$0")")"
INSTALL_FILE="$SCRIPT_DIR/install-databases.exp"

docker run \
    --rm \
    -d \
    --name "$DB_CONTAINER" \
    -e MARIADB_ROOT_PASSWORD="$DB_PASSWORD" \
    --net=host \
    -t mariadb:latest

echo "Waiting for mariadb..."
until docker exec "$DB_CONTAINER" mariadb -uroot -p"$DB_PASSWORD" -e "SELECT 1" &>/dev/null; do
    sleep 1
done

docker run \
    --rm \
    -v "$INSTALL_FILE:/install-databases.exp:ro" \
    -e DB_PASSWORD="$DB_PASSWORD" \
    --net=host \
    -i ubuntu:24.04 bash <<'EOF'
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
EOF
