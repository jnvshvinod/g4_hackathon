FROM centos:latest

MAINTAINER G4

RUN yum -y install httpd

COPY httpd.conf /etc/httpd/conf/

COPY index.html  /var/www/html

CMD ["-D", "FOREGROUND"]

ENTRYPOINT ["/usr/sbin/httpd"]

EXPOSE 80
