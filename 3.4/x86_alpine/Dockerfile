FROM alpine:3.6

LABEL MAINTAINER "Dashlorde <zhouyunlu0216@gmail.com>"

ENV version '3.4.0'

COPY ./start.sh /opt/apache2/start.sh

RUN apk update && apk upgrade && \
    apk add --no-cache wget unzip apache2 php7 postgresql-dev \
    php7-opcache php7-pgsql php7-xmlrpc php7-gd php7-intl php7-session php7-json \
    php7-iconv php7-xml php7-apache2 php7-curl php7-soap php7-openssl php7-ctype php7-zip \
    php7-zlib php7-simplexml php7-dom php7-xmlreader php7-fileinfo php7-mbstring php7-tokenizer

RUN wget -O /var/www/moodle-${version}.tar.gz https://github.com/moodle/moodle/archive/v${version}.tar.gz && \
    cd /var/www && tar -xvzf moodle-${version}.tar.gz && \
    rm -rf /var/www/localhost/htdocs/ && \
	mv /var/www/moodle-${version} /var/www/localhost/htdocs && \
    chmod +x /opt/apache2/start.sh && \
	mkdir -p /var/www/localhost/moodledata && chmod 777 /var/www/localhost/moodledata && \
	chown -R apache:apache /var/www/localhost/moodledata && \
    chmod -R 775 /var/www/localhost/htdocs && \
    chown -R apache:apache /var/www/localhost/htdocs && \
    mkdir -p /run/apache2 && \
    echo "ServerName localhost" >> /etc/apache2/httpd.conf

COPY ./config/php.ini /opt/php/7.0/apache2/php.ini

EXPOSE 80

CMD ["/opt/apache2/start.sh"]
