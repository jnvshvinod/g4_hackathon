FROM centos:latest

MAINTAINER G4

RUN yum -y install httpd

COPY ./httpd.conf /etc/httpd/conf/

COPY ./documentRoot/*  destination_documentRoot

CMD ["-D", "FOREGROUND"]

ENTRYPOINT ["/usr/sbin/httpd"]

EXPOSE port
