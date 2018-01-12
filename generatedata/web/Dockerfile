#
# Docker image for
#
# generatedata (http://generatedata.com)
#
#
# Create:
#
# sudo docker build --rm -t akaer/generatedata . 2>&1 |tee docker_build.log
#
# Run:
#
#  1. Create data container that holds webapp data:
#
#  sudo docker create \
#  -v /var/lib/nginx/html/generatedata \
#  --name generatedata_data akaer/generatedata /bin/true
#
#  2. Run generatedata:
#
#  sudo docker run --rm=true -it \
#   --name generatedata \
#   -v /etc/localtime:/etc/localtime:ro \
#   --volumes-from generatedata_data \
#   -p 80:80 \
#   akaer/generatedata
#
#  3. Backup data
#
#  sudo docker exec -it \
#   generatedata-mysql mysqldump -u <user> -p<Password> \
#   <DB-Name> >backup_$(date +"%Y%m%d_%H%M%S").db
#
#  4. Restore Backup
#
#  a) See 1.
#  b)
#  sudo docker run --rm \
#   --volumes-from generatedata_data \
#   -v $(pwd):/backup akaer/generatedata \
#   bash -c "tar xvzf /backup/<BACKUP_FILE>"
#

FROM akaer/base
LABEL maintainer "André Raabe <andre.raabe@gmail.com>"

ENV MYSQL_DB_HOSTNAME localhost
ENV MYSQL_DB_USERNAME generatedata
ENV MYSQL_DB_PASSWORD P@ssw0rd
ENV MYSQL_DB_NAME generatedata_db
ENV MYSQL_DB_PORT 3306

RUN set -xe \
    && apk update \
    && apk add --no-cache \
        curl \
        git \
        nginx \
        php7 \
        php7-cli \
        php7-fpm \
        php7-gd \
        php7-gettext \
        php7-gmp \
        php7-json \
        php7-ldap \
        php7-mcrypt \
        php7-openssl \
        php7-pcntl \
        php7-mysqli \
        php7-pear \
        php7-pear-net_idna2 \
        php7-pear-net_socket \
        php7-sockets \
        php7-xml \
        php7-zlib \
        tar \
    && rm -rf /var/cache/apk/* \
    && mkdir /tmp/nginx

ADD files/nginx.conf /etc/nginx/nginx.conf
ADD files/run.sh /tmp/run.sh

RUN set -xe \
    && sed -i 's/nginx:x:100:101/nginx:x:1000:101/g' /etc/passwd \
    && sed -i 's/memory_limit = .*/memory_limit = 768M/' /etc/php7/php.ini \
    && sed -i 's/post_max_size = .*/post_max_size = 50M/' /etc/php7/php.ini \
    && echo 'date.timezone = "Europe/Berlin"' >> /etc/php7/php.ini \
    && sed -i '/^user/c \user = nginx' /etc/php7/php-fpm.conf \
    && sed -i '/^group/c \group = nginx' /etc/php7/php-fpm.conf \
    && sed -i 's/^listen.allowed_clients/;listen.allowed_clients/' /etc/php7/php-fpm.conf \
    && chmod +x /tmp/run.sh

RUN set -xe \
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

RUN set -xe \
    && curl -sSL \
        "https://github.com/benkeen/generatedata/archive/master.tar.gz" \
        -o /tmp/generatedata.tar.gz \
    && tar xzf /tmp/generatedata.tar.gz -C /tmp \
    && mv /tmp/generatedata-master /var/lib/nginx/html/generatedata \
    && rm -f /tmp/generatedata.tar.gz

ADD files/phpinfo.php /var/lib/nginx/html/generatedata/phpinfo.php
ADD files/settings.php /var/lib/nginx/html/generatedata/
RUN set -xe \
    && chown nginx:nginx -R /var/lib/nginx/html \
    && chown nginx:nginx -R /var/lib/nginx/tmp/

EXPOSE 80

CMD [ "/tmp/run.sh" ]

