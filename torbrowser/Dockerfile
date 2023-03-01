#
# Docker image for
#
# Tor Browser
#
#
# Create:
#
#  sudo docker build --rm -t akaer/torbrowser . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run -d --name torbrowser \
#       -h torbrowser \
#       -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
#       -v /dev/snd:/dev/snd \
#       -v /dev/shm:/dev/shm \
#       -v /etc/machine-id:/etc/machine-id:ro \
#       -v $(pwd)/tordata:/data \
#       -e DISPLAY=unix$DISPLAY \
#       akaer/torbrowser
#

FROM debian:bullseye-slim
LABEL maintainer "André Raabe <andre.raabe@gmail.com>"

ENV TZ=Europe/Berlin
ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive
ENV TOR_FINGERPRINT 0xEF6E286DDA85EA2A4BA7DE684E2C6E8793298290

USER root
VOLUME [ "/data" ]

RUN set -xe \
    && apt-get update \
    && apt-get upgrade -q -y \
    && apt-get install -q -y \
        ca-certificates \
        curl \
        dirmngr \
        file \
        fonts-freefont-ttf \
        fonts-liberation2 \
        gnupg \
        libasound2 \
        libdbus-glib-1-2 \
        libgl1 \
        libgl1-mesa-dri \
        libglx0 \
        libgtk-3-0 \
        libpciaccess0 \
        libx11-xcb1 \
        libx11-xcb-dev \
        libxrender1 \
        libxt6 \
        ttf-anonymous-pro \
        ttf-bitstream-vera \
        vim \
        wget \
        xz-utils \
        --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

RUN set -xe \
    && LATESTASC=$(curl -s -N https://www.torproject.org/download/ | grep -Eo -m1 "/[a-zA-Z0-9./?=_-]*linux64.*.asc") \
    && LATESTXZ=$(curl -s -N https://www.torproject.org/download/ | grep -Eo -m1 "/[a-zA-Z0-9./?=_-]*linux64.*.xz") \
    && echo "[*] Downloading Tor-Browser" \
    && wget -q -O /opt/tor.tar.xz "https://www.torproject.org/$LATESTXZ" \
    && wget -q -O /opt/tor.tar.xz.asc "https://www.torproject.org/$LATESTASC" \
    && gpg --auto-key-locate nodefault,wkd --locate-keys torbrowser@torproject.org \
    && gpg --fingerprint --keyid-format LONG ${TOR_FINGERPRINT} | grep "Key fingerprint = EF6E 286D DA85 EA2A 4BA7  DE68 4E2C 6E87 9329 8290" \
    && gpg --output ./tor.keyring --export ${TOR_FINGERPRINT} \
    && gpgv --keyring ./tor.keyring /opt/tor.tar.xz.asc /opt/tor.tar.xz \
    && cd /opt && tar xfJ tor.tar.xz \
    && rm -f /opt/tor.tar.xz /opt/tor.tar.xz.asc

RUN set -xe \
    && mkdir -p /data \
    && groupadd -g 1000 -r tor \
    && useradd -r -m -u 1000 -g tor -G audio,video tor \
    && chown tor:tor /data /opt/tor-browser \
    && cd /opt/tor-browser && chown -R tor:tor *

COPY local.conf /etc/fonts/local.conf
COPY fonts.conf /opt/tor-browser/Browser/TorBrowser/Data/fontconfig/fonts.conf

USER tor
WORKDIR /data
ENTRYPOINT ["/bin/bash"]
CMD [ "/opt/tor-browser/Browser/start-tor-browser", "--log", "/dev/stdout" ]

