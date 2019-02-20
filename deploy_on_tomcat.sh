#/bin/sh
wget http://ec2-13-234-48-118.ap-south-1.compute.amazonaws.com:8081/artifactory/list/builds/war/${1}/JavaHelloWorldApp.war
sudo systemctl stop tomcat
sudo rm -f /usr/share/tomcat/webapps/JavaHelloWorldApp.war
sudo rm -rf /usr/share/tomcat/webapps/JavaHelloWorldApp/
sudo cp ./JavaHelloWorldApp.war /usr/share/tomcat/webapps/
sudo systemctl start tomcat
