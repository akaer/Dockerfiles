#!/usr/bin/env bash

set -exu

modify_config() {
    sed -i -e "s|@@MYSQL_DB_HOSTNAME@@|${MYSQL_DB_HOSTNAME}|g" \
           -e "s|@@MYSQL_DB_USER@@|${MYSQL_DB_USER}|g" \
           -e "s|@@MYSQL_DB_PASSWORD@@|${MYSQL_DB_PASSWORD}|g" \
           -e "s|@@MYSQL_DB_NAME@@|${MYSQL_DB_NAME}|g" \
           -e "s|@@MYSQL_DB_PORT@@|${MYSQL_DB_PORT}|g" \
        /var/lib/nginx/html/generatedata/settings.php
}

start_app() {
    chown -R nginx:nginx /var/lib/nginx/html
    php-fpm7 -D -c /etc/php7/php.ini -y /etc/php7/php-fpm.conf -d variables_order="EGPCS"
    nginx -g "daemon off;"
}

modify_config
start_app

