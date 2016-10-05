#
# Docker image for
#
# Firefox
#
#
# Create:
#
# sudo docker build -t akaer/firefox . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run --rm=true -it \
#   --name firefox \
#   -e DISPLAY=$DISPLAY \
#   -v /tmp/.X11-unix:/tmp/.X11-unix \
#   -v /etc/localtime:/etc/localtime:ro \
#   -v $(pwd):/data akaer/firefox
#

FROM akaer/base
MAINTAINER André Raabe <andre.raabe@gmail.com>

RUN set -xe \
    && apk update \
    && apk add --no-cache \
        dbus \
        dbus-x11 \
        firefox-esr \
        ttf-droid \
        ttf-freefont \
        ttf-liberation \
        ttf-ubuntu-font-family \
    && rm -rf /var/cache/apk/*

CMD [ "firefox" ]
