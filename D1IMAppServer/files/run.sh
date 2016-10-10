#!/usr/bin/env bash

set -ex

mkdir -p /var/www/.dell
mkdir -p /var/www/App_Data/SearchIndex
chown www-data:www-data -R /var/www/.dell
chown www-data:www-data -R /var/www/App_Data/

/usr/sbin/apache2ctl -D FOREGROUND

