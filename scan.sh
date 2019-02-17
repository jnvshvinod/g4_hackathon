#!/bin/sh

# Script to Scan for Webservers running in a linux server.

# Add the list of supported Webserver to be identified in this server.
services_to_check=(httpd tomcat)

echo -----------------------------------------------------
echo "                     SCANNING"
echo -----------------------------------------------------

result="{"

for service in "${services_to_check[@]}"
do
echo "Checking for" $service
  if [ "$(systemctl show -p SubState $service| cut -d"=" -f2)" == "running" ]
  then
    result=$result"$service:true,"
  else
    result=$result"$service:false,"
  fi
done
result=$result"status:completed}"

echo $result
