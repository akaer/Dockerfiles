#!/usr/bin/env bash

set -exu

declare -r WEBUSER="nginx"
declare -r WEBGROUP="nginx"

start_app() {
    spawn-fcgi -u ${WEBUSER} -g ${WEBGROUP} \
        -s /var/run/fcgiwrap.socket -- /usr/bin/fcgiwrap

    nginx -g "daemon off;"
}

modify_config() {
    sed -i -e "s|@@SITE_NAME@@|${SITE_NAME}|g" \
           -e "s|@@GIT_BASE_URL@@|${GIT_BASE_URL}|g" \
           -e "s|@@WEB_BASE_URL@@|${WEB_BASE_URL}|g" \
        /etc/gitweb.conf
}

modify_config
start_app

