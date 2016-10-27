#
# Docker image for
#
# remmina
#
#
# Create:
#
# sudo docker build --rm -t akaer/remmina . 2>&1 |tee docker_build.log
#
# Run:
#
# sudo docker run --rm=true -it \
#   --name remmina \
#   -v /etc/localtime:/etc/localtime:ro \
#   -v /tmp/.X11-unix:/tmp/.X11-unix \
#   -e DISPLAY=unix$DISPLAY \
#   -v $HOME/.remmina:/root/.remmina \
#   akaer/remmina
#

FROM akaer/base
MAINTAINER André Raabe <andre.raabe@gmail.com>

ENV NO_AT_BRIDGE 1

RUN set -xe \
    && apk update \
    && apk add --no-cache \
        freetype \
        gdk-pixbuf \
        libx11 \
        mesa-dri-swrast \
        mesa-gl \
        remmina \
        ttf-ubuntu-font-family \
    && rm -rf /var/cache/apk/*

CMD [ "remmina" ]

