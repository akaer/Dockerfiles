#!/usr/bin/env bash

set -exu

modify_config() {
    sed -i -e "s|@@MYSQL_DB_HOSTNAME@@|${MYSQL_DB_HOSTNAME}|g" \
           -e "s|@@MYSQL_DB_USERNAME@@|${MYSQL_DB_USERNAME}|g" \
           -e "s|@@MYSQL_DB_PASSWORD@@|${MYSQL_DB_PASSWORD}|g" \
           -e "s|@@MYSQL_DB_NAME@@|${MYSQL_DB_NAME}|g" \
           -e "s|@@MYSQL_DB_PORT@@|${MYSQL_DB_PORT}|g" \
        /var/lib/nginx/html/testlink/config_db.inc.php

    sed -i -e "s|@@COMPANYNAME@@|${COMPANYNAME}|g" \
           -e "s|@@SMTPRELAY@@|${SMTPRELAY}|g" \
           -e "s|@@ADMINEMAIL@@|${ADMINEMAIL}|g" \
           -e "s|@@DEFAULTSENDERADDRESS@@|${DEFAULTSENDERADDRESS}|g" \
        /var/lib/nginx/html/testlink/custom_config.inc.php
}

start_app() {
    chown -R nginx:nginx /var/lib/nginx/html
    php-fpm5 -D -c /etc/php5/php.ini -y /etc/php5/php-fpm.conf -d variables_order="EGPCS"
    nginx -g "daemon off;"
}

modify_config
start_app

