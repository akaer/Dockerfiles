#
# Docker image for
#
# OpenJRE 8
#
#
# Create:
#
# sudo docker build --rm -t akaer/openjre8 . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run --rm=true -it \
#   --name openjre8 \
#   -v /etc/localtime:/etc/localtime:ro \
#   -v $(pwd):/data akaer/openjre8
#

FROM akaer/base
MAINTAINER André Raabe <andre.raabe@gmail.com>

RUN set -xe \
    && apk update \
    && apk add --no-cache \
        openjdk8-jre \
    && rm -rf /var/cache/apk/*

CMD [ "java","-version" ]

