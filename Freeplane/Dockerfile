#
# Docker image for
#
# Freeplane (https://www.freeplane.org/wiki/index.php/Main_Page)
#
#
# Create:
#
# sudo docker build --rm -t akaer/freeplane-novnc . 2>&1 |tee docker_build.log
#
# Run:
#
# sudo docker run -it --name freeplane-novnc -v
# /etc/localtime:/etc/localtime:ro -p 8083:8083 akaer/freeplane-novnc
#
#
# Then open your browser and head over to http://<docker-host>:<exposed_port>/vnc_lite.html
#
#

FROM akaer/x11-novnc-java
MAINTAINER André Raabe <andre.raabe@gmail.com>

ENV LANG C.UTF-8
ENV SCREEN_RESOLUTION 1024x768
ENV DISPLAY :0
ENV FREEPLANE_VERSION 1.5.21
ENV APP_TO_RUN /opt/freeplane/freeplane.sh

RUN set -xe \
    && apt-get update \
    && apt-get install -y \
        curl \
        unzip \
    && rm -rf /var/lib/apt/lists/* \
    && curl -sSL "http://downloads.sourceforge.net/project/freeplane/freeplane%20stable/freeplane_bin-${FREEPLANE_VERSION}.zip?r=&ts=1454676861&use_mirror=netix" -o /tmp/freeplane.zip \
    && unzip /tmp/freeplane.zip -d /opt \
    && mv /opt/freeplane-${FREEPLANE_VERSION} /opt/freeplane \
    && rm -f /tmp/freeplane.zip

EXPOSE 8083

CMD [ "/usr/bin/supervisord" ]

