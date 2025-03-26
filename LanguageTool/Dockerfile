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

FROM ubuntu:22.04
LABEL maintainer="André Raabe <andre.raabe@gmail.com>"

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Berlin
ENV Java_Xms=1g
ENV Java_Xmx=2g
ENV langtool_pipelinePrewarming=true
ENV langtool_languageModelDir=/srv/ngrams
ENV langtool_verbose=true

RUN set -xe \
    && apt-get update \
    && apt-get install -q -y \
        locales \
        openjdk-17-jre-headless \
        curl \
        unzip \
        build-essential \
        git \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /srv \
    && cd /srv \
    && curl -SL https://internal1.languagetool.org/snapshots/LanguageTool-latest-snapshot.zip -o LanguageTool.zip \
    && unzip LanguageTool.zip \
    && rm -f LanguageTool.zip \
    && mv LanguageTool-* LanguageTool \
    && curl -sSLO https://dl.fbaipublicfiles.com/fasttext/supervised-models/lid.176.bin \
    && curl -sSLO https://languagetool.org/download/ngram-data/ngrams-de-20150819.zip \
    && curl -sSLO https://languagetool.org/download/ngram-data/ngrams-en-20150817.zip \
    && unzip ngrams-de-20150819.zip \
    && unzip ngrams-en-20150817.zip \
    && mkdir -p /srv/ngrams \
    && mv de /srv/ngrams \
    && mv en /srv/ngrams \
    && rm ngrams-de-20150819.zip \
    && rm ngrams-en-20150817.zip \
    && git clone https://github.com/facebookresearch/fastText.git \
    && cd fastText \
    && make \
    && java -version

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && dpkg-reconfigure --frontend=noninteractive locales \
    && update-locale LANG=en_US.UTF-8

ENV LANG=en_US.UTF-8

RUN set -ex \
    && useradd --home-dir /srv --shell /bin/bash languagetool --uid 1000

COPY server.properties /srv/server.properties

EXPOSE 8081

WORKDIR /srv/LanguageTool

USER languagetool

HEALTHCHECK --interval=15s --timeout=3s --start-period=10s --retries=10 \
    CMD curl -X GET -o /dev/null --silent --fail --header 'Accept: application/json' 'http://127.0.0.1:8081/v2/languages' || exit 1

CMD [ "java", "-cp", "languagetool-server.jar", "org.languagetool.server.HTTPServer", "--config", "/srv/server.properties", "--allow-origin", "*", "--public", "--port", "8081" ]

