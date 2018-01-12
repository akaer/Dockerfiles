#
# Docker image for
#
# topydo (https://topydo.org/)
#
#
# Create:
#
# sudo docker build --rm -t akaer/topydo . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run --rm=true -it \
#       --name topydo \
#       -v /etc/localtime:/etc/localtime:ro \
#       -v $(pwd):/data \
#       akaer/topydo
#

FROM akaer/python3
LABEL maintainer "André Raabe <andre.raabe@gmail.com>"


RUN set -ex \
    && pip3 install topydo[columns]

VOLUME /data
WORKDIR /data

ENTRYPOINT [ "topydo" ]

