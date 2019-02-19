#!/bin/sh

echo -----------------------------------------------------
echo "        Pulling Configurations and Artifacts"
echo -----------------------------------------------------

scp -i /opt/jenkinsfiles/tmp/bootstrap_key_${Server_IP} -o StrictHostKeyChecking=no ./httpd/pull.sh ${Username}@${Server_IP}:/tmp/httpd_pull.sh
ssh -i /opt/jenkinsfiles/tmp/bootstrap_key_${Server_IP} -o StrictHostKeyChecking=no ${Username}@${Server_IP} /tmp/httpd_pull.sh > ./httpd/pull_result.json

cat ./httpd/pull_result.json

conffile=$(cat ./httpd/pull_result.json | jq .conffile| tr -d '"')
documentRoot=$(cat ./httpd/pull_result.json | jq .documentRoot| tr -d '"')

rm -rf ./httpd/conffile
scp -i /opt/jenkinsfiles/tmp/bootstrap_key_${Server_IP} -o StrictHostKeyChecking=no ${Username}@${Server_IP}:${conffile} ./httpd/conffile
rm -rf ./httpd/documentRoot
mkdir ./httpd/documentRoot
scp -i /opt/jenkinsfiles/tmp/bootstrap_key_${Server_IP} -o StrictHostKeyChecking=no ${Username}@${Server_IP}:${documentRoot}/* ./httpd/documentRoot/

echo -----------------------------------------------------
echo "        Preparing Docker Image"
echo -----------------------------------------------------

port=$(cat ./httpd/pull_result.json | jq .port| tr -d '"')
sed -i 's:port:'"$port"':g' ./httpd/Dockerfile
sed -i 's:destination_documentRoot:'"$documentRoot"':g' ./httpd/Dockerfile

cat ./httpd/Dockerfile
docker build ./httpd/ -t ${ECR_URL}/g4_hackathon/httpd:${VERSION}

./ecr-login ${AWS_ACCESS_KEY_ID} ${AWS_SECRET_ACCESS_KEY} ${ECR_REGION}

docker push ${ECR_URL}/g4_hackathon/httpd:${VERSION}

docker logout https://${ECR_URL}

