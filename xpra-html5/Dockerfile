#
# Docker image for
#
# xpra with html5
#
#
# Create:
#
# sudo docker build --rm -t akaer/xpra-html5 . 2>&1 |tee docker_build.log
#
# Run:
#
# sudo docker run -it --rm --name xpra-html5 -h xpra-html5 -p 14500:14500 akaer/xpra-html5
#

FROM ubuntu:20.04
LABEL maintainer "André Raabe <andre.raabe@gmail.com>"

ENV TZ=Europe/Berlin
ENV DEBIAN_FRONTEND noninteractive
ENV XPRA_PASSWORD xpra

EXPOSE 14500

RUN set -xe \
    && apt-get update \
    && apt-get install -y -q --no-install-recommends \
        apt-utils \
        binutils \
        ca-certificates \
        curl \
        gnupg \
        ibus \
        less \
        libc-bin \
        openssl \
        python3-rencode \
        python3-requests \
        xfonts-base \
        xterm \
    && UBUNTU_VERSION=$(cat /etc/os-release | grep UBUNTU_CODENAME | sed 's/UBUNTU_CODENAME=//') \
    && curl http://xpra.org/gpg.asc | apt-key add - \
    && echo "deb http://xpra.org/ $UBUNTU_VERSION main" >> /etc/apt/sources.list.d/xpra.list \
    && apt-get update \
    && apt-get install -y -q --no-install-recommends \
        xpra \
        xpra-html5 \
    && ldconfig -p | grep libQt5Core.so.5 | cut -d '>' -f 2 | xargs -I{} strip --remove-section=.note.ABI-tag {} \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/*

COPY files/xpra.conf /etc/xpra/xpra.conf

RUN set -xe \
    && chmod 644 /etc/xpra/ssl-cert.pem

RUN set -xe \
    && useradd --create-home --shell /bin/bash xpra --gid xpra --uid 1000
WORKDIR /home/xpra

RUN set -xe \
    && mkdir -p /run/user/1000/xpra \
    && chown -R 1000 /run/user/1000 \
    && chmod -R 0700 /run/user/1000

COPY files/docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["xterm", "-fullscreen"]
