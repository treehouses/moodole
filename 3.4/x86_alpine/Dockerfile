FROM alpine:3.6

LABEL MAINTAINER "Dashlorde <zhouyunlu0216@gmail.com>"

ENV version '3.4.0'

ADD ./start.sh /etc/nginx/start.sh
COPY ./moodle /etc/nginx/sites-available/moodle.conf

RUN apk update && apk upgrade && \
    apk add --no-cache wget unzip nginx \
    php7 php7-fpm php7-common \
    postgresql-dev php7-opcache php7-pgsql php7-xmlrpc \
    php7-gd php7-intl php7-session php7-json \
    php7-mcrypt php7-ldap\
    php7-iconv php7-xml php7-curl php7-soap \
    php7-openssl php7-ctype php7-zip \
    php7-zlib php7-dom php7-fileinfo\
    php7-xmlreader php7-simplexml\
    php7-mbstring php7-tokenizer

RUN mkdir -p /var/lib/nginx/html && \
    rm -rf /var/lib/nginx/html/* && \
    wget -O /var/lib/nginx/moodle-${version}.tar.gz \
    https://github.com/moodle/moodle/archive/v${version}.tar.gz && \
    cd /var/lib/nginx && tar -xvzf moodle-${version}.tar.gz && \
	mv /var/lib/nginx/moodle-${version}/* /var/lib/nginx/html/ && \
    rm  moodle-${version}.tar.gz && rm /var/lib/nginx/moodle-${version} &&\
    chmod +x /etc/nginx/start.sh && \
	mkdir -p /var/lib/nginx/moodledata && chmod 777 /var/lib/nginx/moodledata && \
	chown -R nginx:nginx /var/lib/nginx/moodledata && \
    chmod -R 775 /var/lib/nginx/html && \
    chown -R nginx:nginx /var/lib/nginx/html && \
    echo "daemon off;" >> /etc/nginx/nginx.conf && \
    sed -i 's/user = nobody/user = nginx/g' /etc/php7/php-fpm.d/www.conf && \
    sed -i 's/^group = nobody/group = nginx/g' /etc/php7/php-fpm.d/www.conf && \
    sed -i 's/;listen.owner = nobody/listen.owner = nginx/g' /etc/php7/php-fpm.d/www.conf && \
    sed -i 's/;listen.group = nobody/listen.group = nginx/g' /etc/php7/php-fpm.d/www.conf && \
    sed -i 's/;listen.mode = 0660/listen.mode = 0660/g' /etc/php7/php-fpm.d/www.conf && \
    sed -i 's/listen = 127.0.0.1:9000/listen = \/var\/run\/php7-fpm.sock/g' /etc/php7/php-fpm.d/www.conf && \
    sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 200M/g' /etc/php7/php.ini && \
    sed -i 's/post_max_size = 8M/post_max_size = 200M/g' /etc/php7/php.ini && \
    mkdir -p /run/nginx && \
    ln -s /etc/nginx/sites-available/moodle.conf /etc/nginx/conf.d/moodle.conf && \
	unlink /etc/nginx/conf.d/default.conf

EXPOSE 80

ADD ./config.php /var/lib/nginx/html/

CMD ["/etc/nginx/start.sh"]
