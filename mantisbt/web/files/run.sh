#!/usr/bin/env bash

set -exu

modify_config() {
    sed -i -e "s|@@MYSQL_DB_HOSTNAME@@|${MYSQL_DB_HOSTNAME}|g" \
           -e "s|@@MYSQL_DB_USERNAME@@|${MYSQL_DB_USERNAME}|g" \
           -e "s|@@MYSQL_DB_PASSWORD@@|${MYSQL_DB_PASSWORD}|g" \
           -e "s|@@MYSQL_DB_NAME@@|${MYSQL_DB_NAME}|g" \
           -e "s|@@MYSQL_DB_PORT@@|${MYSQL_DB_PORT}|g" \
        /var/lib/nginx/html/mantisbt/config/config_inc.php
}

start_app() {
    chown -R nginx:nginx /var/lib/nginx/html
    php-fpm -D -c /etc/php5/php.ini -y /etc/php5/php-fpm.conf -d variables_order="EGPCS"
    nginx -g "daemon off;"
}

modify_config
start_app

