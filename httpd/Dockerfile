FROM centos:latest

MAINTAINER G4

RUN yum -y install httpd

COPY ./conffile /etc/httpd/conf/

COPY ./documentroot/*  /var/www/html/

CMD ["-D", "FOREGROUND"]

RUN systemctl start httpd

RUN systemctl enable httpd

ENTRYPOINT ["/usr/sbin/httpd"]

EXPOSE port
