!#/bin/sh

ip=$1
authentication=$2
username=$3

if ["${authentication}" == "Username:Password" ]
then
	password=$4
	export SSHPASS=$password
	sshpass -e ssh-copy -i ~/.ssh/bootstrap "${username}"@"${ip}"
	cp ~/.ssh/bootstrap /tmp/bootstrap_key
else if ["${authentication}" == "Username:SSH Key" ]
	key=$4
	echo $key > /tmp/bootstrap_key
	chmod 600 /tmp/bootstrap_key
fi

ssh -i /tmp/bootstrap_key "${username}"@"${ip}" hostname

if ["$?" == 0 ]
then
	echo "Bootstrap Suuccessful"
	exit 0
else
	echo "Bootstrap failed"
	exit 1
fi


