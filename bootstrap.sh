#!/bin/sh

ip=$1
authentication=$2
username=$3

# Clean up old keys
rm -rf /root/.ssh/known_hosts
rm -rf /opt/jenkinsfiles/tmp/bootstrap_key_${ip}

echo "Attempting ssh connection to "${username}@${ip}

if [ "${authentication}" == "Username:Password" ]
then
	password=$4
	export SSHPASS=$password
	sshpass -e ssh-copy-id -f -i /opt/jenkinsfiles/bootstrap -o StrictHostKeyChecking=no "${username}"@"${ip}"
	cp /opt/jenkinsfiles/bootstrap /opt/jenkinsfiles/tmp/bootstrap_key_${ip}
elif [ "${authentication}" == "Username:SSH_Key" ]
then
	cp /opt/jenkinsfiles/tmp/SSH_Key /opt/jenkinsfiles/tmp/bootstrap_key_${ip}
fi
chmod 600 /opt/jenkinsfiles/tmp/bootstrap_key_${ip}
ssh -i /opt/jenkinsfiles/tmp/bootstrap_key_${ip} -o StrictHostKeyChecking=no "${username}"@"${ip}" hostname

if [ "$?" == 0 ]
then
	echo "Bootstrap Successful"
	exit 0
else
	echo "Bootstrap failed"
	exit 1
fi
