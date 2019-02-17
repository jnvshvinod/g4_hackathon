#!/bin/sh
echo -----------------------------------------------------
echo "        Preparing Docker Image"
echo -----------------------------------------------------

conffile=$(cat ./pull_result.json | jq .conffile| tr -d '"')
port=$(cat ./pull_result.json | jq .port| tr -d '"')
documentRoot=$(cat ./pull_result.json | jq .documentroot| tr -d '"')

sed -i 's:conffile:'"$conffile"':g' Dockerfile
sed -i 's:port:'"$port"':g' Dockerfile
sed -i 's:documentRoot:'"$documentRoot"':g' Dockerfile

cat ./httpd/Dockerfile
docker build . -t httpd_${BUILD_NUMBER}
