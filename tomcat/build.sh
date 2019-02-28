#!/bin/sh

echo "username"
echo ${Username}
echo ${Server_IP}

echo -----------------------------------------------------
echo "        Pulling Configurations and Artifacts"
echo -----------------------------------------------------

ssh -i /opt/jenkinsfiles/tmp/bootstrap_key_${Username}_${Server_IP} -o StrictHostKeyChecking=no ${Username}@${Server_IP} "rm -rf temp"
ssh -i /opt/jenkinsfiles/tmp/bootstrap_key_${Username}_${Server_IP} -o StrictHostKeyChecking=no ${Username}@${Server_IP} "mkdir temp"
scp -i /opt/jenkinsfiles/tmp/bootstrap_key_${Username}_${Server_IP} -o StrictHostKeyChecking=no ./tomcat/pull.sh ${Username}@${Server_IP}:temp/tomcat_pull.sh
ssh -i /opt/jenkinsfiles/tmp/bootstrap_key_${Username}_${Server_IP} -o StrictHostKeyChecking=no ${Username}@${Server_IP} temp/tomcat_pull.sh > ./tomcat/pull_result.json

cat ./tomcat/pull_result.json

conffile=$(cat ./tomcat/pull_result.json | jq .serverxml| tr -d '"')

echo "conffile is" 
echo $conffile

rm -rf ./tomcat/server.xml
scp -i /opt/jenkinsfiles/tmp/bootstrap_key_${Server_IP} -o StrictHostKeyChecking=no ${Username}@${Server_IP}:${conffile} ./tomcat/server.xml

webapp=$(cat ./tomcat/pull_result.json | jq .webapp| tr -d '"')

rm -rf ./tomcat/webapps/
mkdir -p ./tomcat/webapps

scp -i /opt/jenkinsfiles/tmp/bootstrap_key_${Server_IP} -o StrictHostKeyChecking=no ${Username}@${Server_IP}:${webapp}/* ./tomcat/webapps/

echo -----------------------------------------------------
echo "        Preparing Docker Image"
echo -----------------------------------------------------

port=$(cat ./tomcat/pull_result.json | jq .port| tr -d '"')
sed -i 's:port:'"$port"':g' ./tomcat/Dockerfile

cat ./tomcat/Dockerfile

docker build ./tomcat/ -t ${ECR_URL}/g4_hackathon/tomcat:${VERSION}

./ecr-login ${AWS_ACCESS_KEY_ID} ${AWS_SECRET_ACCESS_KEY} ${ECR_REGION}

docker push ${ECR_URL}/g4_hackathon/tomcat:${VERSION}

docker logout https://${ECR_URL}

ssh -i /opt/jenkinsfiles/tmp/bootstrap_key_${Username}_${Server_IP} -o StrictHostKeyChecking=no ${Username}@${Server_IP} "rm -rf temp"
