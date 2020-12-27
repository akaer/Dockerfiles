#
# Docker image for
#
# nmap
#
# Create:
#
# sudo docker build --rm -t akaer/nmap . 2>&1 |tee docker_build.log
#
# Run:
#
# sudo docker run --rm=true -it \
#   --name nmap --hostname nmap \
#   -v /etc/localtime:/etc/localtime:ro \
#   akaer/nmap
#

FROM akaer/base
LABEL maintainer "André Raabe <andre.raabe@gmail.com>"

RUN set -ex \
    && apk update \
    && apk add --no-cache \
        nmap \
        nmap-scripts \
    && rm -rf /var/cache/apk/* \
    && nmap --script-updatedb

ENTRYPOINT [ "nmap" ]

