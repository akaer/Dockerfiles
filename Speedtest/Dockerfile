#
# Docker image for
#
# Ookla Speedtest :-)
#
#
# Create:
#
# sudo docker build --rm -t akaer/speedtest . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run --rm=true -it \
#       --name speedtest \
#       -v /etc/localtime:/etc/localtime:ro \
#       akaer/speedtest
#

FROM akaer/base
LABEL maintainer "André Raabe <andre.raabe@gmail.com>"

RUN set -ex \
    && apk update \
    && apk add --no-cache \
        curl \
    && rm -rf /root/.cache \
    && rm -rf /var/cache/apk/* \
    && curl -sSL -o speedtest.tgz https://bintray.com/ookla/download/download_file?file_path=ookla-speedtest-1.0.0-armhf-linux.tgz \
    && tar xzf speedtest.tgz \
    && rm speedtest.tgz

CMD [ "./speedtest" ]
