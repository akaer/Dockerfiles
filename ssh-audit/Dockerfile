#
# Docker image for
#
# ssh-audit (https://github.com/arthepsy/ssh-audit)
#
#
# Create:
#
# sudo docker build --rm -t akaer/ssh-audit . 2>&1 |tee docker_build.log
#
# or
#
# sudo docker build --rm --build-arg BRANCH_TO_USE=develop -t akaer/ssh-audit . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run --rm=true -it \
#       --name ssh-audit \
#       -v /etc/localtime:/etc/localtime:ro \
#       akaer/ssh-audit
#

FROM akaer/python
LABEL maintainer "André Raabe <andre.raabe@gmail.com>"

ARG BRANCH_TO_USE=master

RUN set -ex \
    && apk update \
    && apk add --no-cache \
        git \
    && git clone https://github.com/arthepsy/ssh-audit \
    && cd ssh-audit && git checkout ${BRANCH_TO_USE} \
    && apk del --purge git \
    && rm -rf /var/cache/apk/*

ENTRYPOINT [ "python", "ssh-audit/ssh-audit.py" ]

