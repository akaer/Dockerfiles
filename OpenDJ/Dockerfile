#
# Docker image for
#
# OpenDJ
#
#
# Create:
#
# sudo docker build --rm -t akaer/opendj . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run -d \
#   -h ldapserver \
#   --name opendj \
#   -p 389:1389 -p 636:1636 akaer/opendj
#
# Configure:
#
# sudo docker exec -it <CONTAINER-ID> /opt/opendj/bin/dsconfig
#
# HINT: You may want to enable the "Referential Integrity Plugin"
#

FROM openidentityplatform/opendj:latest
LABEL maintainer "André Raabe <andre.raabe@gmail.com>"

ENV DEBIAN_FRONTEND noninteractive
ENV OPENDJ_USER opendj
ENV BASE_DN dc=ldap-lab,dc=com
ENV ROOT_PASSWORD P@ssw0rd
ENV PORT 1389
ENV LDAPS_PORT 1636

ADD healthcheck.sh /healthcheck.sh
ADD entrypoint.sh /entrypoint.sh
ADD configure.sh /configure.sh

HEALTHCHECK --interval=15s --timeout=15s --start-period=30s --retries=10 \
    CMD /healthcheck.sh || exit 1

USER root

RUN set -ex \
    && apt-get update \
    && apt-get install -q -y \
        coreutils \
        net-tools \
    && apt-get upgrade -q -y \
    && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/entrypoint.sh"]
