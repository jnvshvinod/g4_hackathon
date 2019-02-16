#!/bin/sh

# Script to pull configurations of HTTPD server and build docker image.

echo -----------------------------------------------------
echo "        Pulling Configurations and Artifacts"
echo -----------------------------------------------------

# Default system properties, Modify for custom locations, if any
conffile="/etc/httpd/conf/httpd.conf"
echo "Taking Configuration from "$conffile

documentRoot=$(cat /etc/httpd/conf/httpd.conf | grep '^\s*DocumentRoot'|tr -d " "|cut -d'"' -f2)
echo "Taking deployed artifacts from "$documentRoot

port=$(cat $conffile | grep -e '^\s*Listen'|tr -d " "|tr -d "Listen"|head -1)
echo "Webserver listening at port "$port

echo -----------------------------------------------------
echo "        Preparing Docker"
echo -----------------------------------------------------

sed -i 's/conffile/'"conffile"'/g' Dockerfile
sed -i 's/port/'"$port"'/g' Dockerfile
sed -i 's/documentRoot/'"$documentRoot"'/g' Dockerfile      

docker build .
