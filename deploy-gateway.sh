#!/usr/bin/env bash
set -e
export PATH=/home/qureai_support/bin:/home/qureai_support/.local/bin:$PATH

cd /home/qureai_support/deployment

echo "Deployment started"

sudo aws ecr get-login --no-include-email --region=ap-south-1 | /bin/bash

docker volume create --name=dcmio-data | true

docker compose -p gateway -f gateway/docker-compose.yml down --remove-orphans | true
docker compose -p gateway -f gateway/docker-compose.yml up -d

echo "Deployment complete"