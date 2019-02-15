#/bin/sh
systemctl stop tomcat
rm /usr/share/tomcat/webapps/JavaHelloWorldApp.war
rm -rf /usr/share/tomcat/webapps/JavaHelloWorldApp/
cp ./JavaHelloWorldApp.war /usr/share/tomcat/webapps/
systemctl start tomcat