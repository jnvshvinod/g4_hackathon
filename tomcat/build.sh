#!/bin/sh

echo -----------------------------------------------------
echo "        Pulling Configurations and Artifacts"
echo -----------------------------------------------------

scp -i /opt/jenkinsfiles/tmp/bootstrap_key_${Server_IP} -o StrictHostKeyChecking=no ./tomcat/pull.sh ${Username}@${Server_IP}:/tmp/tomcat_pull.sh
ssh -i /opt/jenkinsfiles/tmp/bootstrap_key_${Server_IP} -o StrictHostKeyChecking=no ${Username}@${Server_IP} /tmp/tomcat_pull.sh > ./tomcat/pull_result.json

cat ./tomcat/pull_result.json

conffile=$(cat ./tomcat/pull_result.json | jq .conffile| tr -d '"')

rm -rf ./tomcat/conffile
scp -i /opt/jenkinsfiles/tmp/bootstrap_key_${Server_IP} -o StrictHostKeyChecking=no ${Username}@${Server_IP}:${conffile} ./tomcat/conffile

echo -----------------------------------------------------
echo "        Preparing Docker Image"
echo -----------------------------------------------------

port=$(cat ./tomcat/pull_result.json | jq .port| tr -d '"')
sed -i 's:port:'"$port"':g' ./tomcat/Dockerfile

cat ./tomcat/Dockerfile
docker build ./tomcat/ -t ${ECR_URL}/g4_hackathon/tomcat:${VERSION}

./ecr-login ${ECR_ACCESS_KEY} ${ECR_SECRET_KEY} ${ECR_REGION}

docker push ${ECR_URL}/g4_hackathon/tomcat:${VERSION}

docker logout https://${ECR_URL}
