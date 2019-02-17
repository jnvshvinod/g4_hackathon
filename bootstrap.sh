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
	sshpass -e ssh-copy-id -i ~/.ssh/bootstrap "${username}"@"${ip}"
	cp ~/.ssh/bootstrap /tmp/bootstrap_key
elif [ "${authentication}" == "Username:SSH Key" ]
then
	key=$4
	echo $key
	echo $key > /tmp/bootstrap_key
	chmod 600 /tmp/bootstrap_key
fi

ssh -i /tmp/bootstrap_key "${username}"@"${ip}" hostname

if [ "$?" == 0 ]
then
	echo "Bootstrap Suuccessful"
	exit 0
else
	echo "Bootstrap failed"
	exit 1
fi


