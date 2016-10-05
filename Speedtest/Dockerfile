#
# Docker image for
#
# Speedtest :-)
#
#
# Create:
#
# sudo docker build -t akaer/speedtest . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run --rm=true -it \
#       --name speedtest \
#       -v /etc/localtime:/etc/localtime:ro \
#       akaer/speedtest
#

FROM akaer/python3
MAINTAINER André Raabe <andre.raabe@gmail.com>

RUN set -xe \
    && apk update \
    && apk add --no-cache \
        git \
    && rm -rf /var/cache/apk/*

RUN set -xe \
    && git clone https://github.com/sivel/speedtest-cli.git /tmp/speedtest-cli

WORKDIR /tmp/speedtest-cli

RUN set -xe \
    && python3 setup.py install

CMD [ "speedtest-cli" ]
