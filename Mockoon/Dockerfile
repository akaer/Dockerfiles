#
# Docker image for
#
# Mockoon
#
#
# Create:
#
# sudo docker build --rm -t akaer/mockoon . 2>&1 |tee docker_build.log
#
# Run:
#
# sudo docker run --rm -it -h mockoon --name mockoon -p 14500:14500 -p 3000:3000 --privileged akaer/mockoon
#

FROM akaer/xpra-html5
LABEL maintainer "André Raabe <andre.raabe@gmail.com>"

ENV MOCKOON_VERSION 1.18.1

RUN set -ex \
    && apt-get update \
    && apt-get install -q -y --no-install-recommends \
        coreutils \
        libasound2 \
        libatspi2.0-0 \
        libgbm1 \
        libgtk-3-0 \
        libnotify4 \
        libnss3 \
        libsecret-1-0 \
        libxss1 \
        net-tools \
        xdg-utils \
    && curl -sSLO https://github.com/mockoon/mockoon/releases/download/v${MOCKOON_VERSION}/mockoon-${MOCKOON_VERSION}.deb \
    && dpkg -i mockoon-${MOCKOON_VERSION}.deb \
    && rm -f mockoon-${MOCKOON_VERSION}.deb \
    && echo "/opt/Mockoon" >> /etc/ld.so.conf.d/mockoon.conf \
    && mkdir -p /home/xpra/.config/mockoon \
    && chown -R xpra /home/xpra/.config \
    && echo '{"width":1024,"height":768,"x":0,"y":0,"isMaximized":true,"isFullScreen":false,"displayBounds":{"x":0,"y":0,"width":1920,"height":916}}' >/home/xpra/.config/mockoon/window-state.json \
    && ldconfig \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/*

CMD ["mockoon"]
