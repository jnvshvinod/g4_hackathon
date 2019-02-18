FROM centos:latest

MAINTAINER G4

RUN yum -y install httpd

COPY ./conffile /etc/httpd/conf/

COPY ./documentRoot/*  /var/www/html/

CMD ["-D", "FOREGROUND"]

ENTRYPOINT ["/usr/sbin/httpd"]

EXPOSE port
