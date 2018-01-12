#
# Docker image for
#
# smashing (https://github.com/Smashing/smashing)
#
#
# Create:
#
# sudo docker build --rm -t akaer/smashing . 2>&1 |tee docker_build.log
#
# Run:
#
# sudo docker run -it --rm=true --name dashboard -v /etc/localtime:/etc/localtime:ro -p 3030:3030 akaer/smashing
#
#
# Then open your browser and head over to http://<docker-host>:<exposed_port>
#
#

FROM ubuntu:16.04
LABEL maintainer "André Raabe <andre.raabe@gmail.com>"

ENV LANG C.UTF-8

RUN set -xe \
    && apt-get update \
    && apt-get install -y \
        autoconf \
        bison \
        build-essential \
        ca-certificates \
        curl \
        file \
        git \
        libc6-dev \
        libssl-dev \
        nodejs \
        ruby \
        ruby-dev \
    && curl -sSLO http://www.freetds.org/files/stable/freetds-1.00.63.tar.bz2 \
    && tar xjf freetds-1.00.63.tar.bz2 \
    && cd freetds-1.00.63 \
    && ./configure --prefix=/usr/local --with-tdsver=7.3 \
    && make \
    && make install \
    && rm -f freetds-1.00.63.tar.bz2 \
    && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/* \
    && echo "gem: --no-document" > /etc/gemrc \
    && gem install smashing bundler json

RUN smashing new smashing

WORKDIR /smashing

RUN cd /smashing \
    && bundle \
    && ln -s /smashing/dashboards /dashboards \
    && ln -s /smashing/jobs /jobs \
    && ln -s /smashing/assets /assets \
    && ln -s /smashing/lib /lib-smashing \
    && ln -s /smashing/public /public \
    && ln -s /smashing/widgets /widgets \
    && mkdir /smashing/config \
    && mv /smashing/config.ru /smashing/config/config.ru \
    && ln -s /smashing/config/config.ru /smashing/config.ru \
    && ln -s /smashing/config /config


COPY scripts/wrapper.sh /

VOLUME ["/dashboards", "/jobs", "/lib-smashing", "/config", "/public", "/widgets", "/assets"]

ENV PORT 3030
EXPOSE $PORT
WORKDIR /smashing

CMD [ "/wrapper.sh" ]

