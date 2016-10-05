#
# Docker image for
#
# Python2
#
#
# Create:
#
# sudo docker build -t akaer/python . 2>&1 |tee docker_build.log
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

RUN set -xe \
    && apk update \
    && apk add --no-cache \
        python \
    && rm -rf /var/cache/apk/*

CMD [ "python", "--version" ]

