#
# Docker image for
#
# nginx (for serving static files) (https://nginx.org/en/download.html)
#
#
# Create:
#
# sudo docker build --rm -t akaer/nginx-static . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run --rm=true -it \
#  -v $(pwd)/static:/static \
#  -v /etc/localtime:/etc/localtime:ro \
#  -p 8888:80 \
#  --name nginx-static akaer/nginx-static
#

FROM akaer/base
LABEL maintainer "André Raabe <andre.raabe@gmail.com>"

RUN set -xe \
    && apk update \
    && apk add --no-cache \
        nginx \
    && rm -rf /var/cache/apk/* \
    && mkdir /tmp/nginx

ADD files/nginx.conf /etc/nginx/nginx.conf

RUN set -xe \
    && sed -i 's/nginx:x:100:101/nginx:x:1000:101/g' /etc/passwd \
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80

CMD [ "nginx", "-g daemon off;" ]

