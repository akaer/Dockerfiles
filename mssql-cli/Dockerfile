#
# Docker image for
#
# mssql-cli
#
#
# Create:
#
# sudo docker build --rm -t akaer/mssql-cli . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run --rm=true -it \
#       --name mssql-cli \
#       -v /etc/localtime:/etc/localtime:ro \
#       akaer/mssql-cli
#

FROM ubuntu:16.04
LABEL maintainer "André Raabe <andre.raabe@gmail.com>"

RUN set -ex \
    && apt-get update \
    && apt-get install -y \
        build-essential \
        freetds-common \
        freetds-dev \
        git \
        libaio1 \
        libicu-dev \
        libunwind8 \
        python-pip \
    && pip install --upgrade pip \
    && pip install \
        git+https://github.com/pymssql/pymssql.git \
    && pip install \
        mssql-cli \
    && apt-get remove --purge -y -q \
        build-essential \
        git \
    && apt-get autoclean -y -q \
    && rm -rf /var/lib/apt/lists/*

ENV MSSQL_CLI_TELEMETRY_OPTOUT True

ENTRYPOINT [ "mssql-cli" ]
CMD [ "--version" ]

