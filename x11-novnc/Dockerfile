#
# Docker image for
#
# x11-novnc
#
#
# Create:
#
# sudo docker build --rm -t akaer/x11-novnc . 2>&1 |tee docker_build.log
#
# Run:
#
# sudo docker run -it --name x11-novnc -v /etc/localtime:/etc/localtime:ro -p 8083:8083 akaer/x11-novnc
#
#
# Then open your browser and head over to http://<docker-host>:<exposed_port>/vnc_lite.html
#
#

FROM ubuntu:16.04
LABEL maintainer "André Raabe <andre.raabe@gmail.com>"

ENV LANG C.UTF-8
ENV SCREEN_RESOLUTION 1024x768
ENV DISPLAY :0
ENV APP_TO_RUN xterm
ENV XUSER xuser
ENV HOME /home/${XUSER}

RUN set -xe \
    && apt-get update \
    && apt-get install -y \
        curl \
        git \
        matchbox-window-manager \
        net-tools \
        python-numpy \
        supervisor \
        x11vnc \
        xvfb \
    && adduser --gecos "" --shell /bin/bash --disabled-login --disabled-password ${XUSER} \
    && mkdir -p /home/${XUSER} \
    && git clone --depth 1 https://github.com/novnc/noVNC /home/${XUSER}/novnc \
    && git clone --depth 1 https://github.com/novnc/websockify /home/${XUSER}/novnc/utils/websockify \
    && apt-get --purge remove -y curl git \
    && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/* \
    && chown -R ${XUSER} /home/${XUSER} \
    && chmod -R u=rwX,go=rX /home/${XUSER}

COPY files/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
VOLUME /home/${XUSER}

WORKDIR [ "/home/${XUSER}" ]

EXPOSE 8083

CMD [ "/usr/bin/supervisord" ]

