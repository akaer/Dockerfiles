#
# Docker image for
#
# Chrome
#
#
# Create:
#
# sudo docker build --rm -t akaer/chrome . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run --rm=true -it \
#   --name chrome \
#   -e DISPLAY=$DISPLAY \
#   -v /tmp/.X11-unix:/tmp/.X11-unix \
#   -v /etc/localtime:/etc/localtime:ro \
#   -v $(pwd):/data akaer/chrome
#
# Don't forget to allow X access (e.g. xhost +)
#

FROM akaer/base
LABEL maintainer "André Raabe <andre.raabe@gmail.com>"

ENV NO_AT_BRIDGE 1

RUN set -xe \
    && apk update \
    && apk add --no-cache \
        chromium \
        dbus \
        dbus-x11 \
        freetype \
        gdk-pixbuf \
        libx11 \
        mesa-dri-swrast \
        mesa-gl \
        ttf-droid \
        ttf-freefont \
        ttf-liberation \
        ttf-ubuntu-font-family \
        ttf-ubuntu-font-family \
        udev \
    && rm -rf /var/cache/apk/*

CMD [ "chromium-browser" ]

