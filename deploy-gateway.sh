#!/usr/bin/env bash
set -e
#export PATH=/home/qureai_support/bin:/home/qureai_support/.local/bin:$PATH

cd /qureupdate

echo "gateway Deployment started"

docker volume create --name=dcmio-data | true

docker compose -p gateway -f gateway/docker-compose.yml down --remove-orphans | true
docker compose -p gateway -f gateway/docker-compose.yml up -d

echo "Deployment complete"