#!bin/bash

if [ ! -z "${MOODOLE_POST_MAX_SIZE}" ]
then
  sed -i '/post_max_size/c\post_max_size = '$MOODOLE_POST_MAX_SIZE /etc/php/7.0/apache2/php.ini
fi

if [ ! -z "${MOODOLE_UPLOAD_MAX_FILESIZE}" ]
then
  sed -i '/upload_max_filesize/c\upload_max_filesize = '$MOODOLE_UPLOAD_MAX_FILESIZE /etc/php/7.0/apache2/php.ini
fi

service php7.0-fpm start
service nginx start

tail -f /var/log/nginx/access.log
