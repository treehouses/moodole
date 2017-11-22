FROM i386/ubuntu:16.04
LABEL MAINTAINER "Dashlorde <zhouyunlu0216@gmail.com>"

EXPOSE 80 

ADD ./start.sh /etc/apache2/start.sh 

ADD https://github.com/moodle/moodle/archive/v3.4.0.tar.gz /var/www/moodle-3.4.0.tgz

RUN apt-get update && \ 
	apt-get -y install unzip apache2 php libapache2-mod-php7.0 php-xml php-zip \
        php7.0-mysql php7.0-curl php7.0-xmlrpc php7.0-gd php7.0-intl && \
	rm -rf /var/www/html/ && \
	cd /var/www && tar xvf moodle-3.4.0.tgz && \
	mv /var/www/moodle-3.4.0 /var/www/html && \
	chown -R www-data:www-data /var/www/html && \
	chmod +x /etc/apache2/start.sh && \
	mkdir -p /var/moodledata && chmod 777 /var/moodledata && \
	chown -R www-data:www-data /var/moodledata 
		
CMD ["/etc/apache2/start.sh"]