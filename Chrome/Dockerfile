#
# Docker image for
#
# Chrome
#
#
# Create:
#
# sudo docker build -t akaer/chrome . 2>&1 |tee docker_build.log
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
MAINTAINER André Raabe <andre.raabe@gmail.com>

ENV NO_AT_BRIDGE 1

RUN set -xe \
    && apk update \
    && apk add --no-cache \
        chromium \
        mesa-gl \
        mesa-dri-swrast \
        ttf-ubuntu-font-family \
        freetype \
        libx11 \
        gdk-pixbuf \
        ttf-droid \
        ttf-freefont \
	dbus \
	dbus-x11 \
	udev \
        ttf-liberation \
        ttf-ubuntu-font-family \
    && rm -rf /var/cache/apk/*

CMD [ "chromium-browser" ]

