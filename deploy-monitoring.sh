#!/usr/bin/env bash
set -e
#export PATH=/home/qureai_support/bin:/home/qureai_support/.local/bin:$PATH

cd /lol

echo "monitor Deployment started"

docker volume create --name=dcmio-data | true

docker compose -p monitor -f monitor/docker-compose.yml down --remove-orphans | true
docker compose -p monitor -f monitor/docker-compose.yml up -d

echo "Deployment complete"