#!/bin/sh

# Script to pull configurations of tomcat server and build docker image.

# Default system properties, Modify for custom locations, if any
serverxml="/usr/share/tomcat/conf/server.xml"

port=$(cat $serverxml | grep -e '^\s*Connector port'|tr -d " "|tr -d "Connector port"|head -1)

echo "{ \"serverxml\":\"${serverxml}\",\"port\":\"${port}\"}"
