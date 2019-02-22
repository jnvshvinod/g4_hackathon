#/bin/sh
rm -rf Hackathon.war
wget http://ec2-13-234-48-118.ap-south-1.compute.amazonaws.com:8081/artifactory/list/builds/war/${1}/Hackathon.war
systemctl stop tomcat
rm -f /usr/share/tomcat/webapps/Hackathon.war
rm -rf /usr/share/tomcat/webapps/Hackathon/
cp ./Hackathon.war /usr/share/tomcat/webapps/
systemctl start tomcat
