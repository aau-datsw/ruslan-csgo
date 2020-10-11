# README

## Info

`ruslan-csgo` is a prebuilt docker-image for running a CS:GO server, in collaboration with [RuCAd](https://github.com/aau-datsw/ruslan-rucad), and [Challonge](https://challonge.com).

It's primary use is for the annual LAN-party, for new students at Aalborg University's bachelor's degree in Computer Science and Software Engineering.

## Running

First pull from `frederikspang/ruslan-csgo`, then run the server; here for 27010, and GOTV on 27011.

The docker image exposes $PORT as gameport and $GO_PORT as TV port, and should be adjusted in docker bindings, and env-variables.

```bash
docker pull frederikspang/ruslan-csgo
docker run -d -p 27010:27010 -p 27010:27010/udp -p 27011:27011 -p 27011:27011/udp \
  -e "STEAM_ACCOUNT=MYAPIKEY" \
  -e "SERVER_HOSTNAME=SERVERNAME" \
  -e "SERVER_PASSWORD=SERVERPASS" \
  -e "RCON_PASSWORD=RCON_PASS" \
  -e "PORT=27010" \
  -e "GO_PORT=27011" \
  frederikspang/ruslan-csgo
```
