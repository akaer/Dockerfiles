#
# Docker image for
#
# OpenDJ (Nightly build)
#
#
# Create:
#
# sudo docker build -t akaer/opendj . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run --rm=true -it \
#   --name opendj \
#   -v /etc/localtime:/etc/localtime:ro \
#   -p 389:1389 -p 636:1636 akaer/opendj
#

FROM akaer/openjre8
MAINTAINER André Raabe <andre.raabe@gmail.com>

ENV OPENDJ_USER opendj
ENV OPENDJ_BASEDN dc=ldap-lab,dc=com
ENV OPENDJ_PASSWORD P@ssw0rd
ENV OPENDJ_NUMBER_OF_TESTUSERS 1000

WORKDIR /opt

# Fetch the latest nightly build
RUN set -ex \
    && apk update \
    && apk add --no-cache \
        curl \
    && curl https://forgerock.org/djs/opendjrel.js?948497823 | \
        grep -o "http://.*\.zip" | \
        tail -1 | xargs curl -o opendj.zip \
    && unzip opendj.zip \
    && rm -f opendj.zip

# Creating instance.loc consolidates the writable directories under one root
# We also create the extensions directory
# The strategy is the create a skeleton DJ instance under the instances/template directory
# and use this template to instantiate a new persistent image.
RUN set -ex \
    && echo "/opt/opendj/instances/template" > /opt/opendj/instance.loc\
    && mkdir -p /opt/opendj/instances/template/lib/extensions

RUN set -ex \
    && ./opendj/setup --cli -p 1389 \
        --ldapsPort 1636 --enableStartTLS \
        --generateSelfSignedCertificate \
        --sampleData ${OPENDJ_NUMBER_OF_TESTUSERS} --baseDN ${OPENDJ_BASEDN} \
        -h localhost --rootUserPassword ${OPENDJ_PASSWORD} \
        --acceptLicense --no-prompt --doNotStart \
    && adduser -S -h /home/${OPENDJ_USER} -g "${OPENDJ_USER} user" ${OPENDJ_USER} \
    && chown -R ${OPENDJ_USER} /opt/opendj

# We use there ports because we don't run as root user ;-)
EXPOSE 1389 1636

# Copy in the template the first time DJ runs, and start DJ

VOLUME [ "/opt/opendj" ]
USER ${OPENDJ_USER}
CMD [ "/opt/opendj/bin/start-ds", "--nodetach" ]

