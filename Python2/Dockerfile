#
# Docker image for
#
# Python2
#
#
# Create:
#
# sudo docker build --rm -t akaer/python . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run --rm=true -it \
#       --name python \
#       -v /etc/localtime:/etc/localtime:ro \
#       akaer/python
#

FROM akaer/base
MAINTAINER André Raabe <andre.raabe@gmail.com>

RUN set -ex \
    && apk update \
    && apk add --no-cache \
        python \
    && python -m ensurepip \
    && rm -r /usr/lib/python*/ensurepip \
    && pip install --upgrade pip setuptools \
    && rm -r /root/.cache \
    && rm -rf /var/cache/apk/*

CMD [ "python", "--version" ]

