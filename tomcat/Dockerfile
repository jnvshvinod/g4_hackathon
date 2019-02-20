FROM centos:latest

MAINTAINER G4

RUN yum -y install tomcat8

COPY ./conffile /usr/share/tomcat/conf/server.xml

COPY ./webapps/* /var/lib/tomcat/webapps/

ENTRYPOINT ["/usr/libexec/tomcat/server", "start"]

EXPOSE port
