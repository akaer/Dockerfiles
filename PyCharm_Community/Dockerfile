#
# Docker image for
#
# PyCharm - Community
#
#
# Create:
#
# sudo docker build -t akaer/pycharm-com . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run --rm=true -it \
#       --name pycharm-com
#       -v /etc/localtime:/etc/localtime:ro \
#       -e DISPLAY=$DISPLAY \
#       -v /tmp/.X11-unix:/tmp/.X11-unix \
#       -v $(pwd):/workdir akaer/pycharm-com
#

FROM akaer/openjre8
MAINTAINER André Raabe <andre.raabe@gmail.com>

RUN set -xe \
    && apk update \
    && apk add --no-cache \
        curl \
        freetype \
        git \
        libx11 \
        libxext \
        libxi \
        libxrandr \
        libxrender \
        libxt \
        python \
        python3 \
        ttf-droid \
        ttf-freefont \
        ttf-liberation \
        ttf-ubuntu-font-family \
    && rm -rf /var/cache/apk/*

RUN set -xe \
    && curl -sSL "https://download.jetbrains.com/python/pycharm-community-5.0.5.tar.gz" -o /tmp/pycharm.tar.gz \
    && tar -xvzf /tmp/pycharm.tar.gz \
    && rm -f /tmp/pycharm.tar.gz

CMD [ "/pycharm-community-5.0.5/bin/pycharm.sh" ]

