#
# Docker image for
#
# OpenDJ (Nightly build)
#
#
# Create:
#
# sudo docker build --rm -t akaer/opendj . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run -d \
#   --name opendj \
#   -v /etc/localtime:/etc/localtime:ro \
#   -p 389:1389 -p 636:1636 akaer/opendj
#
# Configure:
#
# sudo docker exec -it <CONTAINER-ID> /opt/opendj/bin/dsconfig
#
# HINT: You may want to enable the "Referential Integrity Plugin"
#

FROM akaer/openjre8
MAINTAINER André Raabe <andre.raabe@gmail.com>

ENV OPENDJ_HOSTNAME opendj.ldap-lab.com
ENV OPENDJ_USER opendj
ENV OPENDJ_ADMIN CN=Directory\ Manager
ENV OPENDJ_BASEDN dc=ldap-lab,dc=com
ENV OPENDJ_PASSWORD P@ssw0rd
ENV OPENDJ_NUMBER_OF_TESTUSERS 500

# Default options for a small instance. Overrride the environment var
# OPENDJ_JAVA_ARGS as needed
ENV OPENDJ_JAVA_ARGS -server -Xmx512m -XX:+UseG1GC

WORKDIR /opt

# Fetch the latest nightly build
RUN set -ex \
    && apk update \
    && apk add --no-cache \
        curl \
    && rm -rf /var/cache/apk/* \
    && curl -sSL https://maven.forgerock.org/repo/repo/org/forgerock/opendj/opendj-server-legacy/3.0.0/opendj-server-legacy-3.0.0.zip \
        -o opendj.zip \
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
    && ./opendj/setup \
        --cli \
        --acceptLicense \
        --ldapPort 1389 \
        --ldapsPort 1636 \
        --adminConnectorPort 4444 \
        --baseDN "${OPENDJ_BASEDN}" \
        --rootUserDN "${OPENDJ_ADMIN}" \
        --rootUserPassword "${OPENDJ_PASSWORD}" \
        --enableStartTLS \
        --generateSelfSignedCertificate \
        --sampleData ${OPENDJ_NUMBER_OF_TESTUSERS} \
        --hostName ${OPENDJ_HOSTNAME} \
        --no-prompt \
        --doNotStart \
    && adduser -S -h /home/${OPENDJ_USER} -g "${OPENDJ_USER} user" ${OPENDJ_USER} \
    && chown -R ${OPENDJ_USER} /opt/opendj

# We use these ports because we don't run as root user ;-)
EXPOSE 1389 1636 4444

# Copy in the template the first time DJ runs, and start DJ

VOLUME [ "/opt/opendj" ]
USER ${OPENDJ_USER}
CMD [ "/opt/opendj/bin/start-ds", "--nodetach" ]

