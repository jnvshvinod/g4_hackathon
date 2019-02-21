#!/bin/sh

# Script to pull configurations of tomcat server and build docker image.

# Default system properties, Modify for custom locations, if any
serverxml="/usr/share/tomcat/conf/server.xml"

port=$(cat server.xml | grep -e '^\s*<Connector port' | head -1 |tr -d " "| cut -d '=' -f 2 | cut -d '"' -f 2)

echo "{ \"serverxml\":\"${serverxml}\",\"port\":\"${port}\"}"
