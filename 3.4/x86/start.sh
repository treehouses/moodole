#!bin/bash

chown -R www-data:www-data /moodle/moodledata

rm -rf /var/www/html/config.php
cp ./config.php /var/www/html/config.php

source /etc/apache2/envvars
tail -F /var/log/apache2/* &
exec apache2 -D FOREGROUND