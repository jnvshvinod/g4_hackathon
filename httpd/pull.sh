#!/bin/sh

# Script to pull configurations of HTTPD server and build docker image.

# Default system properties, Modify for custom locations, if any
conffile="/etc/httpd/conf/httpd.conf"

documentRoot=$(cat /etc/httpd/conf/httpd.conf | grep '^\s*DocumentRoot'|tr -d " "|cut -d'"' -f2)

port=$(cat $conffile | grep -e '^\s*Listen'|tr -d " "|tr -d "Listen"|head -1)

echo "{ \"conffile\":\"${conffile}\",\"documentRoot\":\"${documentRoot}\",\"port\":\"${port}\"}"
