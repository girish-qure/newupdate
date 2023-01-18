set -e
#export PATH=/home/qureai_support/bin:/home/qureai_support/.local/bin:$PATH
cd /qureupdate/misc

bash psqlupgrade.sh

aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 011855203472.dkr.ecr.ap-south-1.amazonaws.com
docker login -u ajayrajqure -p zpsbS8BR2Q
echo "taking backups of cxr and apihub"

cd /qureupdate/misc
bash pgbackup.sh

echo "changing yml and env files"

python3 envchange.py
python3 ymlchange.py

cd /qureupdate

echo "pulling all docker images"

bash pull-image.sh

echo "removing previous dockers"

docker ps -a | awk '{print $1}' | while read in; do docker rm -f $in; done

bash deploy-cxr.sh
bash deploy-gateway.sh
bash deploy-monitoring.sh

echo "Deployment complete"

echo "restoring database"

cd /qureupdate/misc

bash pgrestore.sh

echo "restoring database complete"


echo "running migration complete"

docker cp apihubmigrate.sh  apihub:/srv/apihub/authentication/
docker exec apihub bash /srv/apihub/authentication/apihubmigrate.sh

echo "apihub migration complete"




docker cp cxrmigrate.sh  cxr_api:/srv/cxr_api/cxr_api/
docker exec cxr_api bash /srv/cxr_api/cxr_api/cxrmigrate.sh

echo "cxr migration complete"

echo "apihub commit"

cd /qureupdate/apihub

set -a
source .env

echo $APIHUB_TAG

docker commit apihub qureai/apihub:$APIHUB_TAG

echo "apihub commit done"

echo "migration complete"

docker logout
