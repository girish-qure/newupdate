set -e

cd /qureupdate

docker-compose -p apihub -f apihub/apihub.yml pull
docker-compose -p cxr -f cxr/cxr.yml pull
docker-compose -p cxr -f cxr/workers.yml pull
docker-compose -p gateway -f gateway/docker-compose.yml pull
docker-compose -p monitor -f monitor/docker-compose.yml pull