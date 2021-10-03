#
# Docker image for
#
# Dokuwiki
#
#
# Create:
#
# sudo docker build --rm -t akaer/dokuwiki . 2>&1 |tee docker_build.log
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
LABEL maintainer "André Raabe <andre.raabe@gmail.com>"

ENV WIKINAME "myWiki-name"

RUN set -xe \
    && apk update \
    && apk add --no-cache \
        curl \
        nginx \
        php7 \
        php7-fpm \
        php7-session \
        php7-mbstring \
        php7-gd \
        php7-json \
        php7-openssl \
        php7-pdo_sqlite \
        php7-pear \
        php7-sqlite3 \
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
        "http://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz" -o /tmp/dokuwiki.tar.gz \
    && tar --transform='s#^dokuwiki-\([^/]*\)#var/lib/nginx/html/dokuwiki#' -xzf /tmp/dokuwiki.tar.gz \
    && rm -f /tmp/dokuwiki.tar.gz \

    ### Plugins

    && cd /var/lib/nginx/html/dokuwiki/lib/plugins/ \

    # bring in bureaucracy plugin (https://www.dokuwiki.org/plugin:bureaucracy)
    && mkdir bureaucracy \
    && curl -sSL \
        "https://github.com/splitbrain/dokuwiki-plugin-bureaucracy/tarball/master" -o /tmp/bureaucracy-plugin.tar.gz \
    && tar xvzf /tmp/bureaucracy-plugin.tar.gz -C bureaucracy --strip-components=1 \
    && rm -f /tmp/bureaucracy-plugin.tar.gz \

    # bring in do plugin (https://www.dokuwiki.org/plugin:do)
    && mkdir do \
    && curl -sSL \
        "https://github.com/cosmocode/do/tarball/master" -o /tmp/do.tar.gz \
    && tar xvzf /tmp/do.tar.gz -C do --strip-components=1 \
    && rm -f /tmp/do.tar.gz \

    # bring in sqlite plugin (https://github.com/cosmocode/sqlite/tarball/master)
    && mkdir sqlite \
    && curl -sSL \
        "https://github.com/cosmocode/sqlite/tarball/master" -o /tmp/sqlite.tar.gz \
    && tar xvzf /tmp/sqlite.tar.gz -C sqlite --strip-components=1 \
    && rm -f /tmp/sqlite.tar.gz \

    # bring in pagemod plugin (https://github.com/rendezz/dokuwiki-pagemod/archive/master.zip)
    && mkdir pagemod \
    && curl -sSL \
        "https://github.com/rendezz/dokuwiki-pagemod/tarball/master" -o /tmp/pagemod.tar.gz \
    && tar xvzf /tmp/pagemod.tar.gz -C pagemod --strip-components=1 \
    && rm -f /tmp/pagemod.tar.gz \

    # bring in diagrams plugin (https://www.dokuwiki.org/plugin:diagrams)
    && mkdir diagrams \
    && curl -sSL \
        "https://github.com/cosmocode/dokuwiki-plugin-diagrams/archive/refs/heads/master.tar.gz" -o /tmp/diagrams.tar.gz \
    && tar xvzf /tmp/diagrams.tar.gz -C diagrams --strip-components=1 \
    && rm -f /tmp/diagrams.tar.gz \

    # bring in flowchartjs plugin (https://www.dokuwiki.org/plugin:flowchartjs)
    && mkdir flowchartjs \
    && curl -sSL \
        "https://github.com/ghbore/flowchartjs/archive/refs/heads/master.tar.gz" -o /tmp/flowchartjs.tar.gz \
    && tar xvzf /tmp/flowchartjs.tar.gz -C flowchartjs --strip-components=1 \
    && rm -f /tmp/flowchartjs.tar.gz \

    # bring in fastwiki plugin (https://www.dokuwiki.org/plugin:fastwiki)
    && mkdir fastwiki \
    && curl -sSL \
        "https://github.com/zioth/dokuwiki_fastwiki/archive/master.tar.gz" -o /tmp/fastwiki.tar.gz \
    && tar xvzf /tmp/fastwiki.tar.gz -C fastwiki --strip-components=1 \
    && rm -f /tmp/fastwiki.tar.gz \

    # bring in dw2pdf plugin (https://www.dokuwiki.org/plugin:dw2pdf)
    && mkdir dw2pdf \
    && curl -sSL \
        "https://github.com/splitbrain/dokuwiki-plugin-dw2pdf/tarball/master" -o /tmp/dw2pdf.tar.gz \
    && tar xvzf /tmp/dw2pdf.tar.gz -C dw2pdf --strip-components=1 \
    && rm -f /tmp/dw2pdf.tar.gz \

    # bring in edittable plugin (https://www.dokuwiki.org/plugin:edittable)
    && mkdir edittable \
    && curl -sSL \
        "https://github.com/cosmocode/edittable/archive/refs/heads/master.tar.gz" -o /tmp/edittable.tar.gz \
    && tar xvzf /tmp/edittable.tar.gz -C edittable --strip-components=1 \
    && rm -f /tmp/edittable.tar.gz \

    && chown nginx:nginx -R /var/lib/nginx/html/dokuwiki/data \
    && chown nginx:nginx -R /var/lib/nginx/html/dokuwiki/conf \
    && chown nginx:nginx -R /var/lib/nginx/html/dokuwiki/lib/plugins \
    && chown nginx:nginx -R /var/lib/nginx/tmp/ \
    && rm -f /var/lib/nginx/html/dokuwiki/install.php

ADD files/phpinfo.php /var/lib/nginx/html/dokuwiki/phpinfo.php
ADD files/doku-conf-local.php /var/lib/nginx/html/dokuwiki/conf/local.php
ADD files/doku-conf-plugins.local.php /var/lib/nginx/html/dokuwiki/conf/plugins.local.php
ADD files/doku-conf-acl.auth.php /var/lib/nginx/html/dokuwiki/conf/acl.auth.php
ADD files/doku-conf-users.auth.php /var/lib/nginx/html/dokuwiki/conf/users.auth.php
ADD files/mime.local.conf /var/lib/nginx/html/dokuwiki/conf/mime.local.conf

VOLUME [ "/var/lib/nginx/html/dokuwiki/data/pages/doc" ]
VOLUME [ "/var/lib/nginx/html/dokuwiki/data/media/wiki" ]

EXPOSE 80

CMD [ "/tmp/run.sh" ]

