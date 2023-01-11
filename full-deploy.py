import os
os.system("aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 011855203472.dkr.ecr.ap-south-1.amazonaws.com")
os.system("docker login -u ajayrajqure -p zpsbS8BR2Q")
os.system("bash /qureupdate/deploy-cxr.sh")
os.system("bash /qureupdate/deploy-gateway.sh")
os.system("bash /qureupdate/deploy-monitoring.sh")