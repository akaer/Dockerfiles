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
#   -p 389:389 -p 636:636 \
#   -v $(pwd):/data akaer/opendj
#

FROM akaer/openjre8
MAINTAINER André Raabe <andre.raabe@gmail.com>

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
    && ./opendj/setup --cli -p 389 \
        --ldapsPort 636 --enableStartTLS \
        --generateSelfSignedCertificate \
        --sampleData 1000 --baseDN "dc=ldap-lab,dc=com" \
        -h localhost --rootUserPassword P@ssw0rd \
        --acceptLicense --no-prompt --doNotStart

EXPOSE 389 636

# Copy in the template the first time DJ runs, and start DJ

VOLUME [ "/opt/repo" ]

CMD [ "/opt/opendj/bin/start-ds", "--nodetach" ]

