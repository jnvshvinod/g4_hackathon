#/bin/sh
wget http://ec2-13-234-48-118.ap-south-1.compute.amazonaws.com:8081/artifactory/list/builds/war/${1}/JavaHelloWorldApp.war
systemctl stop tomcat
rm -f /usr/share/tomcat/webapps/JavaHelloWorldApp.war
rm -rf /usr/share/tomcat/webapps/JavaHelloWorldApp/
cp ./JavaHelloWorldApp.war /usr/share/tomcat/webapps/
systemctl start tomcat
