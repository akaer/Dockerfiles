#
# Docker image for
#
# Python3
#
#
# Create:
#
# sudo docker build --rm -t akaer/python3 . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run --rm=true -it \
#       --name python3 \
#       -v /etc/localtime:/etc/localtime:ro \
#       akaer/python3
#

FROM akaer/base
LABEL maintainer "André Raabe <andre.raabe@gmail.com>"

ENV VIRTUAL_ENV=/tmp/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

RUN set -ex \
    && apk update \
    && apk upgrade \
    && apk add --no-cache \
        python3 \
        py3-pip \
    && rm -rf /root/.cache \
    && rm -rf /var/cache/apk/*

RUN set -ex \
    && python -m venv $VIRTUAL_ENV \
    && pip install --upgrade pip \
    && pip install textblob beautifulsoup4 lxml pytest linkchecker

CMD [ "python3", "--version" ]

