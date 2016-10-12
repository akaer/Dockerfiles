#
# Docker image for
#
# Hugo
#
#
# Create:
#
# sudo docker build -t akaer/hugo . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run --rm=true -it \
#   --name hugo \
#   -v /etc/localtime:/etc/localtime:ro \
#   -v $(pwd):/data \
#   akaer/hugo
#
#
# Sample:
#
# docker run --rm=true -it -v $(pwd):/data -p 1313:1313 --user="$(id -u):$(id -g)" akaer/hugo new site samplesite
# docker run --rm=true -it -v $(pwd):/data -p 1313:1313 --user="$(id -u):$(id -g)" akaer/hugo new post/testpost.md
# docker run --rm=true -it -p 1313:1313 -v $(pwd):/data --user="$(id -u):$(id -g)" akaer/hugo server --bind 0.0.0.0 --buildDrafts
#

FROM akaer/base
MAINTAINER André Raabe <andre.raabe@gmail.com>

ENV HUGO_VERSION 0.17

RUN set -ex \
    && apk update \
    && apk add --no-cache \
        curl \
    && rm -rf /var/cache/apk/* \
    && curl -sSL \
        https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz \
        -o /tmp/hugo_${HUGO_VERSION}_linux-64bit.tgz \
    && tar -vxzf /tmp/hugo_${HUGO_VERSION}_linux-64bit.tgz \
    && mv hugo_${HUGO_VERSION}_linux_amd64/hugo_${HUGO_VERSION}_linux_amd64 /usr/bin/hugo \
    && rm -f /tmp/hugo_${HUGO_VERSION}_linux-64bit.tgz \
    && rm -rf hugo_${HUGO_VERSION}_linux_amd64

VOLUME [ "/data" ]
WORKDIR /data
EXPOSE 1313
ENTRYPOINT [ "hugo" ]
CMD [ "version" ]

