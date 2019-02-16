#!/bin/sh
#script to check for services and paths
   service=httpd

#   i=`ps -eaf | grep -i $service |sed '/^$/d' | wc -l`
#   if [[ $i > 1 ]]
#   then
#   echo "$service is running!!!"
#   else
#   echo "$service is not running!!!"
#   fi

#  check for the path of httpd
    if [ $service = "httpd" ]
    then
    echo "service is httpd"
#   conffiletemp=`cat /etc/init.d/httpd | grep httpd.conf`
#   conffile=$(echo $conffiletemp | cut -d ':' -f 2)
#   echo "Path of configuration file of httpd"
    conffile="/etc/httpd/conf/httpd.conf"
#   deployfoldertemp=`cat $conffile | grep 'DocumentRoot "'`
#   deployfolder=$(echo  $deployfoldertemp | cut -d '"' -f 2)
    deployfoldertemp=`cat $conffile | grep '^\s*DocumentRoot'|tr -d " "`       
    echo "Deployfoldertemp"
    echo $deployfoldertemp

    
deployfolder=$(echo $deployfoldertemp | cut -d '"' -f 2)
    echo "Path of DocumentRoot is"
    echo $deployfolder
#   cp -R $deployfolder /root
#   porttemp=`cat $conffile | grep  '^Listen [0-9]*'`
#   port=$(echo $porttemp | cut -d ' ' -f 2)
    port=`cat $conffile | grep -e '^\s*Listen'|tr -d " "|tr -d "Listen"`
    echo $port
    sed -i 's/EXPOSE 82/EXPOSE '"$port"'/g' Dockerfile
    sed -i 's:/var/www/html1:'"$deployfolder"':g' Dockerfile      
    fi
