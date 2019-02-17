#!/bin/sh

# Script to Scan for Webservers running in a linux server.

# Add the list of supported Webserver to be identified in this server.
services_to_check=(httpd tomcat)

echo -----------------------------------------------------
echo "                     SCANNING"
echo -----------------------------------------------------

result="{\n"

for service in "${services_to_check[@]}"
do
echo "Checking for" $service
  if [ "$(systemctl show -p SubState $service| cut -d"=" -f2)" == "running" ]
  then
    echo $service is running
    result=$result+" $service:true,\n" 
    setup=$setup" $service"
  else
    result=$result+" $service:false,\n" 
    echo $service is not running
  fi
done
result=$result+" $status:completed\n}"
echo $result
echo Setup will continue for below web servers.
echo $setup


