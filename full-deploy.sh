set -e
#export PATH=/home/qureai_support/bin:/home/qureai_support/.local/bin:$PATH

cd /qureupdate/misc

echo "changing yml and env files"

python3 envchange.py
python3 ymlchange.py

cd /qureupdate

bash deploy-cxr.sh
bash deploy-gateway.sh
bash deploy-monitoring.sh

echo "Deployment complete"