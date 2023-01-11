set -e
#export PATH=/home/qureai_support/bin:/home/qureai_support/.local/bin:$PATH

cd /qureupdate/misc

echo "changing yml and env files"

python3 envchange.py
python3 ymlchange.py

echo "Deployment complete"