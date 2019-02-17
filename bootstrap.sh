#!/bin/sh

ip=$1
authentication=$2
username=$3

echo ${ip}
echo ${authentication}
echo ${username}

if [ "${authentication}" == "Username:Password" ]
then
	password=$4
	echo $password
	export SSHPASS=$password
	sshpass -e ssh-copy-id -f -i /opt/jenkinsfiles/bootstrap "${username}"@"${ip}"
	cp /opt/jenkinsfiles/bootstrap /opt/jenkinsfiles/tmp/bootstrap_key_${ip}
elif [ "${authentication}" == "Username:SSH Key" ]
then
	key=$4
	echo $key
	echo $key > /opt/jenkinsfiles/tmp/bootstrap_key_${ip}
	chmod 600 /opt/jenkinsfiles/tmp/bootstrap_key_${ip}
fi

ssh -i /opt/jenkinsfiles/tmp/bootstrap_key_${ip} "${username}"@"${ip}" hostname

if [ "$?" == 0 ]
then
	echo "Bootstrap Suuccessful"
	exit 0
else
	echo "Bootstrap failed"
	exit 1
fi
