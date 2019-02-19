FROM centos:latest

MAINTAINER G4

RUN yum -y install tomcat8

COPY server.xml /usr/share/tomcat/conf/server.xml

CMD ["catalina.sh", "run"]

EXPOSE 8080
