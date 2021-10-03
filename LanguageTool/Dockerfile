#
# Docker image for
#
# LanguageTool (https://www.languagetool.org/)
#
#
# Create:
#
# sudo docker build --rm -t akaer/lt . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run --rm=true -it \
#   --name languagetool \
#   -v /etc/localtime:/etc/localtime:ro \
#   -p 8081:8081 \
#   akaer/lt
#
#

FROM akaer/openjre8
LABEL maintainer "André Raabe <andre.raabe@gmail.com>"

ENV LT_VERSION 5.3

RUN set -ex \
    && apk update \
    && apk add --no-cache \
        curl \
        unzip \
    && cd /srv \
    && curl -SL https://www.languagetool.org/download/LanguageTool-${LT_VERSION}.zip -o LanguageTool-${LT_VERSION}.zip \
    && unzip LanguageTool-${LT_VERSION}.zip \
    && rm -f LanguageTool-${LT_VERSION}.zip \
    && rm -rf /var/cache/apk/*

EXPOSE 8081

WORKDIR /srv/LanguageTool-${LT_VERSION}

CMD [ "java", "-cp", "languagetool-server.jar", "org.languagetool.server.HTTPServer", "--public", "--port", "8081" ]

