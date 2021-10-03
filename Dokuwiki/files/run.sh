#!/bin/bash

set -ex

if [[ ! -e /var/lib/nginx/html/dokuwiki/data/pages/doc/readme.txt ]]; then
    echo "====== Welcome to your wiki ======" > \
        /var/lib/nginx/html/dokuwiki/data/pages/doc/readme.txt
fi

sed -i "s|@@WIKINAME@@|${WIKINAME}|g" /var/lib/nginx/html/dokuwiki/conf/local.php

chown nginx:nginx -R /var/lib/nginx/html/dokuwiki/data
chown nginx:nginx -R /var/lib/nginx/html/dokuwiki/conf
chown nginx:nginx -R /var/lib/nginx/html/dokuwiki/lib/plugins
chown nginx:nginx -R /var/lib/nginx/tmp/

sed -i 's|nobody|nginx|g' /etc/php7/php-fpm.d/www.conf

php-fpm7 -D -c /etc/php7/php.ini -y /etc/php7/php-fpm.conf -d variables_order="EGPCS"
nginx -g "daemon off;"
