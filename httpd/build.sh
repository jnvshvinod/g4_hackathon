#!/bin/sh

echo -----------------------------------------------------
echo "        Pulling Configurations and Artifacts"
echo -----------------------------------------------------

scp -i /opt/jenkinsfiles/tmp/bootstrap_key_${Server_IP} -o StrictHostKeyChecking=no ./httpd/pull.sh ${Username}@${Server_IP}:/tmp/httpd_pull.sh
ssh -i /opt/jenkinsfiles/tmp/bootstrap_key_${Server_IP} -o StrictHostKeyChecking=no ${Username}@${Server_IP} /tmp/httpd_pull.sh > ./httpd/pull_result.json

cat ./httpd/pull_result.json

conffile=$(cat ./pull_result.json | jq .conffile| tr -d '"')
documentRoot=$(cat ./pull_result.json | jq .documentRoot| tr -d '"')

scp -i /opt/jenkinsfiles/tmp/bootstrap_key_${Server_IP} -o StrictHostKeyChecking=no ${Username}@${Server_IP}:${conffile} ./conffile
scp -i /opt/jenkinsfiles/tmp/bootstrap_key_${Server_IP} -o StrictHostKeyChecking=no ${Username}@${Server_IP}:${documentRoot}/* ./documentRoot/

echo -----------------------------------------------------
echo "        Preparing Docker Image"
echo -----------------------------------------------------

port=$(cat ./pull_result.json | jq .port| tr -d '"')
sed -i 's:port:'"$port"':g' ./httpd/Dockerfile

cat ./httpd/Dockerfile
docker build ./httpd/Dockerfile -t httpd_${BUILD_NUMBER}
