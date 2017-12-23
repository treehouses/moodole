#!bin/bash

# populate environment first

# /etc/nginx/sites-available/moodle
NGINX_CONFIG="/etc/nginx/sites-available/moodle"

if [ ! -z "${MOODOLE_MAX_BODY_SIZE}" ]
then
  sed -i '/client_max_body_size/c\\tclient_max_body_size '$MOODOLE_MAX_BODY_SIZE';' $NGINX_CONFIG
fi

if [ ! -z "${MOODOLE_BODY_TIMEOUT}" ]
then
  sed -i '/client_body_timeout/c\\tclient_body_timeout '$MOODOLE_BODY_TIMEOUT';' $NGINX_CONFIG
fi

# /etc/php/7.0/fpm/php-fpm.conf
PHP_FM_CONFIG="/etc/php/7.0/fpm/php-fpm.conf"
echo "[www]" >> $PHP_FM_CONFIG

if [ ! -z "${MOODOLE_DB_URL}" ]
then
  echo "env[MOODOLE_DB_URL] = '$MOODOLE_DB_URL'" >> $PHP_FM_CONFIG
fi

if [ ! -z "${MOODOLE_DB_NAME}" ]
then
  echo "env[MOODOLE_DB_NAME] = '$MOODOLE_DB_NAME'" >> $PHP_FM_CONFIG
fi

if [ ! -z "${MOODOLE_DB_USER}" ]
then
  echo "env[MOODOLE_DB_USER] = '$MOODOLE_DB_USER'" >> $PHP_FM_CONFIG
fi

if [ ! -z "${MOODOLE_DB_PASS}" ]
then
  echo "env[MOODOLE_DB_PASS] = '$MOODOLE_DB_PASS'" >> $PHP_FM_CONFIG
fi

if [ ! -z "${MOODOLE_DB_PORT}" ]
then
  echo "env[MOODOLE_DB_PORT] = '$MOODOLE_DB_PORT'" >> $PHP_FM_CONFIG
fi

service php7.0-fpm start
service nginx start

tail -f /var/log/nginx/access.log
