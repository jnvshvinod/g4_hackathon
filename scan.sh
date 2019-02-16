#!/bin/sh

# Script to Scan for Webservers running in a linux server.

# Add the list of supported Webserver to be identified in this server.
services_to_check=(httpd tomcat)

echo -----------------------------------------------------
echo "                     SCANNING"
echo -----------------------------------------------------

for service in "${services_to_check[@]}"
do
echo "Checking for" $service
if [ "$(systemctl show -p SubState $service| cut -d"=" -f2)" == "running" ]
then
  echo $service is running
setup=$setup" $service"
else
  echo $service is not running
fi
done
echo Setup will continue for below web servers.
echo $setup


