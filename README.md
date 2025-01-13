# mangos_docker

an easy way to run mangos locally in docker for testing

## running

``` bash
docker pull ghcr.io/pikdum/mangos_docker
# or: docker build . -t ghcr.io/pikdum/mangos_docker

# path to vanilla client, the directory with WoW.exe
# you'll want version 1.12.1 build 5875
# this is for ./generate.sh
export WOW_DIR="/path/to/vanilla/client"

# creates _generated/, only do this once
./generate.sh

# setup database, only do this once
./database.sh

# run realmd + mangosd
# this opens the mangosd console
# on exit, destroys realmd + mangosd containers
# so after setup, this will be the only thing you need to use
./start.sh

# once it's running, set up a user:
account create test test
account set gmlevel test 3

# to connect, change server to 127.0.0.1:3725 in realmlist.wtf
# useful logs in _logs/
```

## removing

``` bash
docker remove mangos-mangosd --force
docker remove mangos-realmd --force
docker remove mangos-mariadb --force
docker network remove mangos-net --force
# then just delete files
```

