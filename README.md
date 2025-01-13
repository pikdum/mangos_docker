# mangos_docker

an easy way to run mangos locally in docker for testing

## running

``` bash
# path to vanilla client, the directory with WoW.exe
# you'll want version 1.12.1 build 5875
# this is for generating dbc.sqlite + maps
# only do this once
export WOW_DIR="/path/to/vanilla/client"
./generate.sh

# setup database, only do this once
./database.sh

# run realmd + mangosd
# this opens the mangosd console
# on exit, destroys realmd + mangosd containers
./start.sh

# once it's running, set up a user:
account create test test
account set gmlevel test 3

# to connect, change server to 127.0.0.1:3725 in realmlist.wtf
```
