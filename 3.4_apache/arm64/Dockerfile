FROM multiarch/ubuntu-core:arm64-xenial
LABEL MAINTAINER "Sahil Phule <sahil@ole.org>"
LABEL MAINTAINER "Dashlorde <zhouyunlu0216@gmail.com>"

ENV version '3.4.0'

EXPOSE 80

ADD ./start.sh /etc/apache2/start.sh

RUN apt-get update && \
	apt-get -y install wget unzip apache2 php libapache2-mod-php7.0 php-xml php-zip \
        php7.0-pgsql php7.0-curl php7.0-xmlrpc php7.0-gd php7.0-intl php7.0-mysql

RUN wget -O /var/www/moodle-${version}.tar.gz https://github.com/moodle/moodle/archive/v${version}.tar.gz && \
	rm -rf /var/www/html/ && \
	cd /var/www && tar xf moodle-${version}.tar.gz && \
	rm moodle-${version}.tar.gz && \
	mv /var/www/moodle-${version} /var/www/html && \
	chown -R www-data:www-data /var/www/html && \
	chmod +x /etc/apache2/start.sh &&\
	mkdir -p /var/www/moodledata && chmod 777 /var/www/moodledata && \
	chown -R www-data:www-data /var/www/moodledata

COPY ./config.php /var/www/html/

CMD ["/etc/apache2/start.sh"]
