#
# Docker image for
#
# PyCharm - Community
#
#
# Create:
#
# sudo docker build --rm -t akaer/pycharm-com . 2>&1 |tee docker_build.log
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
    && python -m ensurepip \
    && rm -r /usr/lib/python*/ensurepip \
    && pip install --upgrade pip setuptools \
    && rm -r /root/.cache \
    && rm -rf /var/cache/apk/*

RUN set -xe \
    && curl -sSL "https://download-cf.jetbrains.com/python/pycharm-community-2016.3.tar.gz" -o /tmp/pycharm.tar.gz \
    && tar -xzf /tmp/pycharm.tar.gz \
    && rm -f /tmp/pycharm.tar.gz

CMD [ "/pycharm-community-2016.3/bin/pycharm.sh" ]

