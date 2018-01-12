#
# Docker image for
#
# x11-novnc-java
#
#
# Create:
#
# sudo docker build --rm -t akaer/x11-novnc-java . 2>&1 |tee docker_build.log
#
# Run:
#
# sudo docker run -it --name x11-novnc-java -v /etc/localtime:/etc/localtime:ro -p 8083:8083 akaer/x11-novnc-java
#
#
# Then open your browser and head over to http://<docker-host>:<exposed_port>/vnc_lite.html
#
#

FROM akaer/x11-novnc
LABEL maintainer "André Raabe <andre.raabe@gmail.com>"

ENV LANG C.UTF-8
ENV SCREEN_RESOLUTION 1024x768
ENV DISPLAY :0
ENV APP_TO_RUN xterm

RUN set -xe \
    && apt-get update \
    && apt-get install -y \
        openjdk-8-jre-headless \
         ttf-ubuntu-font-family \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 8083

CMD [ "/usr/bin/supervisord" ]

