#/bin/sh
sudo rm -rf Hackathon.war
wget http://ec2-13-234-48-118.ap-south-1.compute.amazonaws.com:8081/artifactory/list/builds/war/${1}/Hackathon.war
sudo systemctl stop tomcat
sudo rm -f /usr/share/tomcat/webapps/Hackathon.war
sudo rm -rf /usr/share/tomcat/webapps/Hackathon/
sudo cp ./Hackathon.war /usr/share/tomcat/webapps/
sudo systemctl start tomcat
