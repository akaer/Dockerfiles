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
#   --name nmap \
#   -v /etc/localtime:/etc/localtime:ro \
#   akaer/nmap
#

FROM debian:buster-slim
LABEL maintainer "André Raabe <andre.raabe@gmail.com>"

RUN set -xe \
    && apt-get update \
    && apt-get install -y \
        nmap \
        --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* \
    && nmap --script-updatedb

CMD [ "nmap", "--version" ]

