set -e
#export PATH=/home/qureai_support/bin:/home/qureai_support/.local/bin:$PATH

aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 011855203472.dkr.ecr.ap-south-1.amazonaws.com
docker login -u ajayrajqure -p zpsbS8BR2Q
echo "taking backups of cxr and apihub"

cd /qureupdate/misc
bash pgbackup.sh

echo "changing yml and env files"

python3 envchange.py
python3 ymlchange.py

cd /qureupdate

bash deploy-cxr.sh
bash deploy-gateway.sh
bash deploy-monitoring.sh

echo "Deployment complete"