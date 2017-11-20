FROM i386/ubuntu:16.04
LABEL MAINTAINER "Dashlorde <zhouyunlu0216@gmail.com>"

VOLUME ["/var/moodledata", "/var/www/html"]
EXPOSE 80 

ADD ./start.sh /etc/apache2/start.sh

RUN apt-get update && \ 
	apt-get -y install apache2 php libapache2-mod-php7.0 php-xml php-zip \
        php7.0-mysql php7.0-curl php7.0-xmlrpc php7.0-gd php7.0-intl && \	
	chown -R www-data:www-data /var/www/html && \
	chmod +x /etc/apache2/start.sh

CMD ["/etc/apache2/start.sh"]
