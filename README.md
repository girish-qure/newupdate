# Qure box upgradation
## Installation steps

- sudo su 
- run these 2 commands in system
```
mkdir /qureupdate 
git clone https://github.com/girish-qure/newupdate.git /qureupdate
```
- enter file path of envs and yml’s in **`/qureupdate/misc/var.py`**
```
    cd  /qureupdate/misc
    enter in this dir and make changes in var.py file
    enter these variable values(you have add these according to current deployment)

        apienv='/home/qure/qure/apihub/apihub.env'
        psqlenv='/home/qure/qure/apihub/psql.env'
        cxrenv='/home/qure/qure/cxr/cxr.env'
        apiyml='/home/qure/qure/apihub/apihub.yml'
        cxryml='/home/qure/qure/cxr/cxr.yml'
        workeryml='/home/qure/qure/cxr/workers.yml'
```
- now final step run **`full-deploy.sh`** file(make sure you are as sudo)
```
cd  /qureupdate
./full-deploy.sh
```
- if you followed above steps properly upgradation should be sucessfull without any issue


- what `full-deploy.sh` will do
```
    docker login
    take postgres backup of previous version
    make changes in env files, copy previous env variable in new envs
    make changes in yml, change volume names as previous one, make new one for postgress
    deploy dockers, apihub, cxr dcmio and monitoring stuff
    restore postgres backup in new version
    run migration in api hub and will take care of cors header
    run migrations in cxr
    commit apihub
    docker logout
```

- work for future
```
    -make versions managable
    -logs additions
    -maybe a UI
    -ignore postgress backup and upgrade if already on latest version
    -etc
```