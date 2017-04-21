#
# Docker image for
#
# mantis bugtracker (http://mantisbt.org/)
#
#
# Create:
#
# sudo docker build --rm -t akaer/mantisbt . 2>&1 |tee docker_build.log
#
# Run:
#
#  1. Create data container that holds the data:
#
#  sudo docker create \
#  -v /var/lib/nginx/html/mantisbt \
#  --name mantisbt_data akaer/mantisbt /bin/true
#
#  2. Run mantisbt:
#
#  sudo docker run --rm=true -it \
#   --name mantisbt \
#   -v /etc/localtime:/etc/localtime:ro \
#   --volumes-from mantisbt_data \
#   -p 80:80 \
#   akaer/mantisbt
#
#  3. Backup data
#
#  sudo docker exec -it \
#   mantisbt-mysql mysqldump -u <user> -p<Password> \
#   <DB-Name> >backup_$(date +"%Y%m%d_%H%M%S").db
#
#  4. Restore Backup
#
#  a) See 1.
#  b)
#  sudo docker run --rm \
#   --volumes-from mantisbt_data \
#   -v $(pwd):/backup akaer/mantisbt \
#   bash -c "tar xvzf /backup/<BACKUP_FILE>"
#
#
# Default user: administrator / root
#

FROM akaer/base
MAINTAINER André Raabe <andre.raabe@gmail.com>

ENV MYSQL_DB_HOSTNAME localhost
ENV MYSQL_DB_USERNAME mantisbt
ENV MYSQL_DB_PASSWORD P@ssw0rd
ENV MYSQL_DB_NAME mantisbt_db
ENV MYSQL_DB_PORT 3306
ENV MANTISBT_VER 2.3.1
ENV MANTISBT_MD5 39b6c79d7b6379b02103efd97ee43edc

RUN set -xe \
    && apk update \
    && apk add --no-cache \
        curl \
        nginx \
        php5 \
        php5-fpm \
        php5-gd \
        php5-json \
        php5-ldap \
        php5-mysql \
        php5-mysqli \
        tar \
    && rm -rf /var/cache/apk/* \
    && mkdir /tmp/nginx

ADD files/nginx.conf /etc/nginx/nginx.conf
ADD files/run.sh /tmp/run.sh

RUN set -xe \
    && sed -i 's/nginx:x:100:101/nginx:x:1000:101/g' /etc/passwd \
    && sed -i 's/memory_limit = .*/memory_limit = 768M/' /etc/php5/php.ini \
    && sed -i 's/post_max_size = .*/post_max_size = 50M/' /etc/php5/php.ini \
    && echo 'date.timezone = "Europe/Berlin"' >> /etc/php5/php.ini \
    && sed -i '/^user/c \user = nginx' /etc/php5/php-fpm.conf \
    && sed -i '/^group/c \group = nginx' /etc/php5/php-fpm.conf \
    && sed -i 's/^listen.allowed_clients/;listen.allowed_clients/' /etc/php5/php-fpm.conf \
    && chmod +x /tmp/run.sh

RUN set -xe \
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

RUN set -xe \
    && curl -sSL \
        "https://jaist.dl.sourceforge.net/project/mantisbt/mantis-stable/${MANTISBT_VER}/mantisbt-${MANTISBT_VER}.tar.gz" \
        -o /tmp/mantisbt-${MANTISBT_VER}.tar.gz \
    && cd /tmp \
    && echo "${MANTISBT_MD5}  mantisbt-${MANTISBT_VER}.tar.gz" | md5sum -c \
    && tar xzf /tmp/mantisbt-${MANTISBT_VER}.tar.gz -C /tmp \
    && mv /tmp/mantisbt-${MANTISBT_VER} /var/lib/nginx/html/mantisbt \
    && rm -f /tmp/mantisbt-${MANTISBT_VER}.tar.gz

ADD files/phpinfo.php /var/lib/nginx/html/mantisbt/phpinfo.php
ADD files/config_inc.php /var/lib/nginx/html/mantisbt/config/config_inc.php
RUN set -xe \
    && chown nginx:nginx -R /var/lib/nginx/html \
    && chown nginx:nginx -R /var/lib/nginx/tmp/

EXPOSE 80

CMD [ "/tmp/run.sh" ]

