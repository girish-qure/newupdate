#!/usr/bin/env bash
set -e
# for latest docker compose
#export PATH=/home/qureai_support/bin:/home/qureai_support/.local/bin:$PATH

#cd /home/qureai_support/deployment

echo "Deployment started"

#sudo aws ecr get-login --no-include-email --region=ap-south-1 | /bin/bash
# aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin awsqure.dkr.ecr.ap-south-1.amazonaws.com

docker volume create --name=qxr-checkpoints | true
docker volume create --name=qxr-data | true
docker volume create --name=qxr-notebooks | true
docker volume create --name=apihub-data | true
docker volume create --name=apihub-notebooks | true
docker volume create --name=psql-data | true
docker volume create --name=dcmio-data | true

echo $1
echo $2
echo $3
echo $4

if [[ "$4" == "pull-only" ]]; then
    echo "only pulling dockers"
    APIHUB_TAG=$1 docker-compose -p apihub -f apihub/docker-compose.yml pull
    CXRAPI_TAG=$2 CHECKPOINTS_TAG=$3 docker-compose -p cxr -f cxr/cxr.yml pull
    CXRAPI_TAG=$2 CHECKPOINTS_TAG=$3 docker-compose -p cxr -f cxr/workers.yml pull

else
    echo "deploying dockers"
    APIHUB_TAG=$1 docker-compose -p apihub -f apihub/docker-compose.yml pull
    CXRAPI_TAG=$2 CHECKPOINTS_TAG=$3 docker-compose -p cxr -f cxr/cxr.yml pull
    CXRAPI_TAG=$2 CHECKPOINTS_TAG=$3 docker-compose -p cxr -f cxr/workers.yml pull

    APIHUB_TAG=$1 docker-compose -p apihub -f apihub/docker-compose.yml down --remove-orphans | true
    APIHUB_TAG=$1 docker-compose -p apihub -f apihub/docker-compose.yml up -d

    CXRAPI_TAG=$2 CHECKPOINTS_TAG=$3 docker-compose -p cxr -f cxr/cxr.yml down --remove-orphans | true
    CXRAPI_TAG=$2 CHECKPOINTS_TAG=$3 docker-compose -p cxr -f cxr/cxr.yml up -d

    CXRAPI_TAG=$2 CHECKPOINTS_TAG=$3 docker-compose -p workers -f cxr/workers.yml down --remove-orphans | true
    CXRAPI_TAG=$2 CHECKPOINTS_TAG=$3 docker-compose -p workers -f cxr/workers.yml up -d
fi


echo "Deployment complete"
