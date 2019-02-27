#/bin/sh
echo "Removing old temp artifacts"
rm -rf ./temp/Hackathon.war

echo "Downloading new artifacts"
wget http://ec2-13-234-48-118.ap-south-1.compute.amazonaws.com:8081/artifactory/list/builds/war/${1}/Hackathon.war ./temp/

echo "Stopping tomcat service"
systemctl stop tomcat

echo "Removing old artifacts"
rm -rf /usr/share/tomcat/webapps/Hackathon/Hackathon.war

echo "Copy new artifacts"
cp ./temp/Hackathon.war /usr/share/tomcat/webapps/

echo "Restarting tomcat service"
systemctl start tomcat
