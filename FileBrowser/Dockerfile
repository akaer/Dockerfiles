#
# Docker image for
#
# web based file server for browsing the current directory
#
#
# Create:
#
# sudo docker build -t akaer/filebrowser . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run --rm=true -it \
#	--name filebrowser \
#	-v /etc/localtime:/etc/localtime:ro \
#	-v $(pwd):/usr/share/nginx/html:ro \
#	-p 9999:80 \
#	akaer/filebrowser
#

FROM akaer/base
MAINTAINER André Raabe <andre.raabe@gmail.com>

RUN set -xe \
    && apk update \
    && apk add --no-cache \
        nginx \
    && rm -rf /var/cache/apk/*

RUN set -xe \
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

ADD files/nginx.conf /etc/nginx/nginx.conf
ADD files/default.conf /etc/nginx/conf.d/default.conf

WORKDIR /usr/share/nginx/html

EXPOSE 80

CMD [ "nginx", "-g", "daemon off;" ]

