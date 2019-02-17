#!/bin/sh
echo -----------------------------------------------------
echo "        Preparing Docker Image"
echo -----------------------------------------------------

conffile=$(cat ./pull_result.json | jq .conffile| tr -d '"')
port=$(cat ./pull_result.json | jq .port| tr -d '"')
documentRoot=$(cat ./pull_result.json | jq .documentroot| tr -d '"')

sed -i 's:conffile:'"$conffile"':g' ./httpd/Dockerfile
sed -i 's:port:'"$port"':g' ./httpd/Dockerfile
sed -i 's:documentRoot:'"$documentRoot"':g' ./httpd/Dockerfile

cat ./httpd/Dockerfile
docker build ./httpd/Dockerfile -t httpd_${BUILD_NUMBER}
