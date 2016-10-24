#
# Docker image for
#
# shellcheck (https://github.com/koalaman/shellcheck)
#
#
# Create:
#
# sudo docker build --rm -t akaer/shellcheck . 2>&1 |tee docker_build.log
#
# Run:
#
# sudo docker run --rm=true -it \
#   --name shellcheck \
#   -v /etc/localtime:/etc/localtime:ro \
#   -v $(pwd):/data:ro \
#   akaer/shellcheck <SCRIPT-TO-TEST>
#

FROM koalaman/shellcheck
MAINTAINER André Raabe <andre.raabe@gmail.com>

ENV SHELLCHECK_USER sshck
ENV SHELLCHECK_HOME /home/${SHELLCHECK_USER}

RUN set -xe \
    && adduser -S -h ${SHELLCHECK_HOME} -g "${SHELLCHECK_USER} user" ${SHELLCHECK_USER} \
    && chown -R ${SHELLCHECK_USER} ${SHELLCHECK_HOME}

USER ${SHELLCHECK_USER}

VOLUME [ "/data" ]
WORKDIR /data

ENTRYPOINT [ "shellcheck" ]

