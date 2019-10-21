#!/bin/bash

export SERVER_HOSTNAME="${SERVER_HOSTNAME:-SpangTester123}"
export SERVER_PASSWORD="${SERVER_PASSWORD:-changeme}"
export RCON_PASSWORD="${RCON_PASSWORD:-changeme}"
export STEAM_ACCOUNT="${STEAM_ACCOUNT:-changeme}"
export IP="${IP:-0.0.0.0}"
export PORT="${PORT:-27015}"
export GO_PORT="${GO_PORT:-27020}"
export TICKRATE="${TICKRATE:-128}"
export GAME_TYPE="${GAME_TYPE:-0}"
export GAME_MODE="${GAME_MODE:-1}"
export MAP="${MAP:-de_dust2}"
export MAPGROUP="${MAPGROUP:-mg_active}"
export MAXPLAYERS="${MAXPLAYERS:-12}"
export IS_LAN="${IS_LAN:-0}"

: ${SERVER:?"ERROR: SERVER IS NOT SET!"}

cd $SERVER

### Create dynamic server config
cat << SERVERCFG > $SERVER/csgo/cfg/server.cfg
hostname "$SERVER_HOSTNAME"
rcon_password "$RCON_PASSWORD"
sv_password "$SERVER_PASSWORD"
sv_lan "$IS_LAN"
sv_cheats 0
get5_check_auths 0
sv_region 3
tv_port $GO_PORT
tv_enable 1
tv_delay 120
SERVERCFG

./srcds_run \
  -debug \
  -console \
  -usercon \
  -game csgo \
  -tickrate $TICKRATE \
  -port $PORT \
  -maxplayers_override $MAXPLAYERS \
  -autoupdate \
  -ip $IP \
  +game_type $GAME_TYPE \
  +game_mode $GAME_MODE \
  +mapgroup $MAPGROUP \
  +map $MAP \
  +ip $IP \
  +net_public_adr $IP \
  +sv_setsteamaccount $STEAM_ACCOUNT \
  +tv_port $GO_PORT \
  +exec custom
