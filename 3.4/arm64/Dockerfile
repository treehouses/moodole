FROM multiarch/ubuntu-core:arm64-xenial
LABEL MAINTAINER "Sahil Phule <sahil@ole.org>"
LABEL MAINTAINER "Dashlorde <zhouyunlu0216@gmail.com>"
LABEL MAINTAINER "Abdurrachman Mappuji <mappuji@ole.org>"
LABEL MAINTAINER "dogi <stefan@unterhauser.name>"

ENV version '3.4.0'

EXPOSE 80

ADD ./start.sh /etc/nginx/
COPY ./moodle /etc/nginx/sites-available/moodle.template

RUN apt-get update && \
	apt-get -y install \
	nginx php-fpm php-common \
	php-mbstring php-xmlrpc \
	php-soap php-gd php-xml \
	php-intl php-pgsql php-mysqlnd php-cli \
	php-mcrypt php-ldap php-zip php-curl \
	wget gettext-base && \
	apt-get -y autoclean && \
	apt-get -y autoremove && \
	rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/html && \
    wget -O /var/www/moodle-${version}.tar.gz \
		https://github.com/moodle/moodle/archive/v${version}.tar.gz && \
	rm -rf /var/www/html/ && \
	cd /var/www && tar xf moodle-${version}.tar.gz && \
	mv /var/www/moodle-${version} /var/www/html && \
	rm  moodle-${version}.tar.gz && \
	chown -R www-data:www-data /var/www/html && \
	chmod +x /etc/nginx/start.sh && \
	mkdir -p /var/www/moodledata && chmod 777 /var/www/moodledata && \
	chown -R www-data:www-data /var/www/moodledata && \
	ln -s /etc/nginx/sites-available/moodle /etc/nginx/sites-enabled/ && \
	unlink /etc/nginx/sites-enabled/default

ADD ./config.php /var/www/html/

CMD ["/etc/nginx/start.sh"]
