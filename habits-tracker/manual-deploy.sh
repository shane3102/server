#!/usr/bin/env bash

cd /etc/nixos/habits-tracker

echo "$(date --utc +%FT%TZ): Running build..."
docker compose rm -f
docker compose build

export OLD_CONTAINERS=$(docker ps -aqf "name=habits-tracker")

echo "$(date --utc +%FT%TZ): Scaling services up..."
docker compose up -d --no-deps --scale habits-tracker-server-spring=2 --no-recreate habits-tracker-server-spring

echo "$(date --utc +%FT%TZ): Scaling down old services..."
docker container rm -f $OLD_CONTAINERS

docker compose up -d --no-deps --scale habits-tracker-server-spring=1 --no-recreate habits-tracker-server-spring

echo "$(date --utc +%FT%TZ): Reloading caddy..."
export CADDY_CONTAINER=$(docker ps -aqf "name=caddy")
docker exec -it $CADDY_CONTAINER caddy reload -c /etc/caddy/Caddyfile

echo "$(date --utc +%FT%TZ): Release succeed!"

