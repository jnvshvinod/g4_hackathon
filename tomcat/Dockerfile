FROM centos:latest

MAINTAINER G4

RUN yum -y install tomcat8

COPY ./server.xml /usr/share/tomcat/conf/

COPY ./webapps/* /var/lib/tomcat/webapps/

ENTRYPOINT ["/usr/libexec/tomcat/server", "start"]

EXPOSE port
