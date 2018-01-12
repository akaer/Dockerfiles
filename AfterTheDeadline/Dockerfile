#
# Docker image for
#
# AfterTheDeadline (http://www.afterthedeadline.com/)
#
#
# Create:
#
# sudo docker build --rm -t akaer/atd . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run --rm=true -it \
#   --name atd \
#   -v /etc/localtime:/etc/localtime:ro \
#   -p 1049:1049 \
#   akaer/atd
#
#

FROM akaer/openjre8
LABEL maintainer "André Raabe <andre.raabe@gmail.com>"

ENV ATD_VERSION 081310

RUN set -ex \
    && apk update \
    && apk add --no-cache \
        curl \
    && cd /srv \
    && curl -SL http://www.polishmywriting.com/download/atd_distribution${ATD_VERSION}.tgz | tar -xz \
    && chmod -R a+x /srv/atd \
    && sed -i 's/127\.0\.0\.1/0\.0\.0\.0/g' /srv/atd/run.sh \
    && sed -i 's/-XX:+AggressiveHeap/-XX:ParallelGCThreads=8 -XX:+AggressiveHeap/g' /srv/atd/run.sh \
    && rm -rf /var/cache/apk/*

EXPOSE 1049

WORKDIR /srv/atd

CMD [ "/bin/bash", "./run.sh" ]

