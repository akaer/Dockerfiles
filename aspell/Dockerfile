#
# Docker image for
#
# aspell
#
#
# Create:
#
# sudo docker build --rm -t akaer/aspell . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run --rm=true -it \
#  --name aspell \
#  -v $(pwd):/data akaer/aspell
#

FROM alpine:latest
LABEL maintainer "André Raabe <andre.raabe@gmail.com>"

ENV TERM dumb

RUN set -ex \
    && apk add --no-cache \
        ca-certificates \
        bash \
        aspell \
        aspell-en \
        aspell-de \
    && rm -rf /var/cache/apk/* \
    && mkdir /data

VOLUME /data
WORKDIR /data

CMD [ "aspell" ]

