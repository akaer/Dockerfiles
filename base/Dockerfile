#
# Docker image for
#
# base - this is our Alpine Linux based base docker container
#
#
# Create:
#
# sudo docker build --rm -t akaer/base . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run --rm=true -it \
#  --name base \
#  -v /etc/localtime:/etc/localtime:ro \
#  -v $(pwd):/data akaer/base
#

FROM alpine:latest
LABEL maintainer="André Raabe <andre.raabe@gmail.com>"

ENV TERM=dumb

RUN set -ex \
    && apk add --no-cache \
        ca-certificates \
        bash \
        curl \
    && rm -rf /var/cache/apk/*

CMD [ "/bin/bash" ]

