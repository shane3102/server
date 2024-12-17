#!/usr/bin/env bash

cd /etc/nixos/illchess

echo "$(date --utc +%FT%TZ): Running build..."
docker compose rm -f
docker compose build

export OLD_CONTAINERS=$(docker ps -aqf "name=illchess")

echo "$(date --utc +%FT%TZ): Scaling services up..."
docker compose up -d --no-deps --scale chess-api-gateway=2 --no-recreate chess-api-gateway
docker compose up -d --no-deps --scale chess-player-info-service=2 --no-recreate chess-player-info-service
docker compose up -d --no-deps --scale chess-stockfish-service=2 --no-recreate chess-stockfish-service
docker compose up -d --no-deps --scale chess-game-service=2 --no-recreate chess-game-service
docker compose up -d --no-deps --scale chess-frontend=2 --no-recreate chess-frontend

echo "$(date --utc +%FT%TZ): Scaling down old services..."
docker container rm -f $OLD_CONTAINERS

docker compose up -d --no-deps --scale chess-frontend=1 --no-recreate chess-frontend
docker compose up -d --no-deps --scale chess-api-gateway=1 --no-recreate chess-api-gateway
docker compose up -d --no-deps --scale chess-player-info-service=1 --no-recreate chess-player-info-service
docker compose up -d --no-deps --scale chess-stockfish-service=1 --no-recreate chess-stockfish-service
docker compose up -d --no-deps --scale chess-game-service=1 --no-recreate chess-game-service

echo "$(date --utc +%FT%TZ): Reloading caddy..."
export CADDY_CONTAINER=$(docker ps -aqf "name=caddy")
docker exec -it $CADDY_CONTAINER caddy reload -c /etc/caddy/Caddyfile

echo "$(date --utc +%FT%TZ): Release succeed!"

