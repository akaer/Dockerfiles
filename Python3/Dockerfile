#
# Docker image for
#
# Python3
#
#
# Create:
#
# sudo docker build --rm -t akaer/python3 . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run --rm=true -it \
#       --name python3 \
#       -v /etc/localtime:/etc/localtime:ro \
#       akaer/python3
#

FROM akaer/base
MAINTAINER André Raabe <andre.raabe@gmail.com>

RUN set -ex \
    && apk update \
    && apk add --no-cache \
        python3 \
    && python3 -m ensurepip \
    && rm -r /usr/lib/python*/ensurepip \
    && pip3 install --upgrade pip setuptools \
    && rm -r /root/.cache \
    && rm -rf /var/cache/apk/*

CMD [ "python3", "--version" ]

