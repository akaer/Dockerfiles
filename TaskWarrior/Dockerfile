#
# Docker image for
#
# Taskwarrior (https://taskwarrior.org/)
#
#
# Create:
#
# sudo docker build --rm -t akaer/taskwarrior . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run --rm=true -it \
#       --name taskwarrior \
#       -v /etc/localtime:/etc/localtime:ro \
#       -v $(pwd):/workdir/task \
#       akaer/taskwarrior
#

FROM akaer/base
LABEL maintainer "André Raabe <andre.raabe@gmail.com>"

RUN set -ex \
    && apk update \
    && apk add --no-cache \
        task \
    && echo "data.location=/data" > ~/.taskrc \
    && rm -rf /var/cache/apk/*

VOLUME /data
WORKDIR /data

ENTRYPOINT [ "task" ]

