#
# Docker image for
#
# pyLanguageTool (https://github.com/Findus23/pyLanguagetool)
#
#
# Create:
#
# sudo docker build --rm -t akaer/pylt . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run -i --rm \
#       --name pylt \
#       akaer/pylt
#

FROM akaer/python3
LABEL maintainer "André Raabe <andre.raabe@gmail.com>"

RUN set -ex \
    && apk update \
    && apk add --no-cache \
        bash \
    && rm -rf /var/cache/apk/*

RUN set -ex \
    && pip3 install pylanguagetool beautifulsoup4 \
    && mkdir /data

VOLUME /data
WORKDIR /data

CMD [ "/bin/bash" ]
#ENTRYPOINT [ "pylanguagetool" ]
#CMD [ "--help" ]

