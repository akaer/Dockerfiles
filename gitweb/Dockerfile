#
# Docker image for
#
# gitweb
#
#
# Create:
#
# sudo docker build --rm -t akaer/gitweb . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run --rm=true -it \
#	--name gitweb \
#	-e GIT_BASE_URL="my-git-server" \
#	-e WEB_BASE_URL="http://my-web-server:8888/" \
#	-e SITE_NAME="my-site-name" \
#	-v /etc/localtime:/etc/localtime:ro \
#       -v /srv/www:/var/www/localhost/htdocs:ro \
#	-v $(pwd):/repos:ro \
#	-p 9999:80 \
#	akaer/gitweb
#

FROM akaer/base
MAINTAINER André Raabe <andre.raabe@gmail.com>

ENV GIT_BASE_URL my-git-server
ENV WEB_BASE_URL http://my-web-server:8888/
ENV SITE_NAME my-site-name

RUN set -xe \
    && apk update \
    && apk add --no-cache \
        fcgiwrap \
        git-gitweb \
        nginx \
        perl-cgi \
        spawn-fcgi \
        highlight \
    && rm -rf /var/cache/apk/*

RUN set -xe \
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

ADD files/gitweb.conf /etc/gitweb.conf
ADD files/nginx.conf /etc/nginx/nginx.conf
ADD files/default.conf /etc/nginx/conf.d/default.conf
ADD files/start.sh /usr/start.sh
ADD files/index.html /var/www/localhost/htdocs/index.html

VOLUME /repos
VOLUME /var/www/localhost/htdocs/

EXPOSE 80

CMD [ "/usr/start.sh" ]

