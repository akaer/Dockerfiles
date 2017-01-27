#
# Docker image for
#
# testlink (http://testlink.org/)
#
#
# Create:
#
# sudo docker build --rm -t akaer/testlink . 2>&1 |tee docker_build.log
#
# Run:
#
#  1. Create data container that holds wiki data:
#
#  sudo docker create \
#  -v /var/lib/nginx/html/testlink \
#  --name testlink_data akaer/testlink /bin/true
#
#  2. Run testlink:
#
#  sudo docker run --rm=true -it \
#   --name testlink \
#   -v /etc/localtime:/etc/localtime:ro \
#   --volumes-from testlink_data \
#   -p 80:80 \
#   akaer/testlink
#
#  3. Backup data
#
#  sudo docker exec -it \
#   testlink-mysql mysqldump -u <user> -p<Password> \
#   <DB-Name> >backup_$(date +"%Y%m%d_%H%M%S").db
#
#  4. Restore Backup
#
#  a) See 1.
#  b)
#  sudo docker run --rm \
#   --volumes-from testlink_data \
#   -v $(pwd):/backup akaer/testlink \
#   bash -c "tar xvzf /backup/<BACKUP_FILE>"
#

#
# Default login: admin / admin
#

FROM akaer/base
MAINTAINER André Raabe <andre.raabe@gmail.com>

ENV MYSQL_DB_HOSTNAME localhost
ENV MYSQL_DB_USERNAME testlink
ENV MYSQL_DB_PASSWORD P@ssw0rd
ENV MYSQL_DB_NAME testlink_db
ENV MYSQL_DB_PORT 3306
ENV TESTLINK_VER 1.9.15
ENV TESTLINK_MD5 ba9d53dce4f1aac3c69a0d7d426a4e06

ENV COMPANYNAME MyCompany
ENV SMTPRELAY relay.mycompany.com
ENV ADMINEMAIL testlink-admin@mycompany.com
ENV DEFAULTSENDERADDRESS noreply-testlink@mycompany.com

RUN set -xe \
    && apk update \
    && apk add --no-cache \
        curl \
        git \
        nginx \
        php5 \
        php5-bcmath \
        php5-cli \
        php5-ctype \
        php5-curl \
        php5-fpm \
        php5-gd \
        php5-gmp \
        php5-iconv \
        php5-json \
        php5-ldap \
        php5-mysql \
        php5-mysqli \
        php5-openssl \
        php5-sqlite3 \
        php5-xml \
        php5-xmlreader \
        php5-xmlrpc \
        vim \
        vimdiff \
        tar \
    && rm -rf /var/cache/apk/* \
    && mkdir /tmp/nginx

ADD files/nginx.conf /etc/nginx/nginx.conf
ADD files/run.sh /tmp/run.sh

RUN set -xe \
    && sed -i 's/nginx:x:100:101/nginx:x:1000:101/g' /etc/passwd \
    && sed -i 's/memory_limit = .*/memory_limit = 768M/' /etc/php5/php.ini \
    && sed -i 's/post_max_size = .*/post_max_size = 50M/' /etc/php5/php.ini \
    && sed -i 's/max_execution_time = .*/max_execution_time = 4500/' /etc/php5/php.ini \
    && sed -i 's/session.gc_maxlifetime = .*/session.gc_maxlifetime = 6000/' /etc/php5/php.ini \
    && sed -i 's/max_input_vars = .*/max_input_vars = 10000/' /etc/php5/php.ini \
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
        "https://github.com/TestLinkOpenSourceTRMS/testlink-code/archive/${TESTLINK_VER}.tar.gz" \
        -o /tmp/testlink-${TESTLINK_VER}.tar.gz \
    && cd /tmp \
    && echo "${TESTLINK_MD5}  testlink-${TESTLINK_VER}.tar.gz" | md5sum -c \
    && tar xzf /tmp/testlink-${TESTLINK_VER}.tar.gz -C /tmp \
    && mv /tmp/testlink-code-${TESTLINK_VER} /var/lib/nginx/html/testlink \
    && rm -f /tmp/testlink-${TESTLINK_VER}.tar.gz

ADD files/phpinfo.php /var/lib/nginx/html/testlink/phpinfo.php
ADD files/config_db.inc.php /var/lib/nginx/html/testlink/config_db.inc.php
ADD files/custom_config.inc.php /var/lib/nginx/html/testlink/custom_config.inc.php
RUN set -xe \
    && mkdir -p /var/testlink/logs \
    && mkdir -p /var/testlink/upload_area \
    && chown nginx:nginx -R /var/lib/nginx/html \
    && chown nginx:nginx -R /var/lib/nginx/tmp/ \
    && chown nginx:nginx -R /var/testlink \
    && chmod 0755 -R /var/testlink

EXPOSE 80

CMD [ "/tmp/run.sh" ]

