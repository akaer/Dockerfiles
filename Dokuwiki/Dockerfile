#
# Docker image for
#
# Dokuwiki
#
#
# Create:
#
# sudo docker build -t akaer/dokuwiki . 2>&1 |tee docker_build.log
#
# Run:
#
#  1. Create data container that holds wiki data:
#
#  sudo docker create \
#  -v /var/lib/nginx/html/dokuwiki \
#  --name wikidata akaer/dokuwiki /bin/true
#
#  2. Run dokuwiki:
#
#  sudo docker run --rm=true -it \
#   --name dokuwiki \
#   -v /etc/localtime:/etc/localtime:ro \
#   --volumes-from wikidata \
#   -p 80:80 \
#   akaer/dokuwiki
#
#  3. Backup wiki data
#
#  sudo docker run --rm \
#   --volumes-from wikidata \
#   -v $(pwd):/backup akaer/dokuwiki \
#       tar czvf /backup/backup_dokuwiki_$(date +"%Y%m%d_%H%M%S").tar.gz \
#       /var/lib/nginx/html/dokuwiki
#
#  4. Restore Backup
#
#  a) See 1.
#  b)
#  sudo docker run --rm \
#   --volumes-from wikidata \
#   -v $(pwd):/backup akaer/dokuwiki \
#   bash -c "tar xvzf /backup/<BACKUP_FILE>"
#

FROM akaer/base
MAINTAINER André Raabe <andre.raabe@gmail.com>

RUN set -xe \
    && apk update \
    && apk add --no-cache \
        curl \
        nginx \
        php5 \
        php5-fpm \
        php5-gd \
        php5-json \
        php5-openssl \
        php5-xml \
        php5-zlib \
        php5-pear \
    && rm -rf /var/cache/apk/* \
    && mkdir /tmp/nginx

ADD files/nginx.conf /etc/nginx/nginx.conf
ADD files/run.sh /tmp/run.sh
ADD files/index.html /var/lib/nginx/html/index.html

RUN set -xe \
    && sed -i 's/nginx:x:100:101/nginx:x:1000:1000/g' /etc/passwd \
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
        "http://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz" -o /tmp/dokuwiki.tar.gz \
    && tar xvzf /tmp/dokuwiki.tar.gz -C /tmp \
    && mv /tmp/dokuwiki-2016-06-26a /var/lib/nginx/html/dokuwiki \
    && rm -f /tmp/dokuwiki.tar.gz \
    && chown -R nginx:nginx /var/lib/nginx/html \
    && chown nginx:nginx -R /var/lib/nginx/tmp/

VOLUME [ "/var/lib/nginx/html/dokuwiki" ]

EXPOSE 80

CMD [ "/tmp/run.sh" ]

