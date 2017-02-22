#
# Docker image for
#
# sqlmap (https://sqlmap.org/)
#
#
# Create:
#
# sudo docker build --rm -t akaer/sqlmap . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run --rm=true -it \
#       --name sqlmap \
#       -v /etc/localtime:/etc/localtime:ro \
#       akaer/sqlmap
#

FROM akaer/python
MAINTAINER André Raabe <andre.raabe@gmail.com>

RUN set -ex \
    && apk update \
    && apk add --no-cache \
        git \
    && git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git sqlmap \
    && apk del --purge git \
    && rm -rf /var/cache/apk/*

ENTRYPOINT [ "python", "sqlmap/sqlmap.py" ]

