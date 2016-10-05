#
# Docker image for
#
# Python3
#
#
# Create:
#
# sudo docker build -t akaer/python3 . 2>&1 |tee docker_build.log
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

RUN set -xe \
    && apk update \
    && apk add --no-cache \
        python3 \
    && rm -rf /var/cache/apk/*

CMD [ "python3", "--version" ]

