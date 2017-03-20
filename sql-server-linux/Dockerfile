#
# Docker image for
#
# Microsoft SQL Server
#
#
# Create:
#
#  sudo docker build --rm -t akaer/mssql-server-linux . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run --rm=true -it \
#       --name mssql-server-linux \
#       -p 1433:1433 \
#       -v /etc/localtime:/etc/localtime:ro \
#       akaer/mssql-server-linux
#
#

FROM microsoft/mssql-server-linux:latest
MAINTAINER André Raabe <andre.raabe@gmail.com>

ENV SQL_SERVER_AGENT mssql-server-agent_14.0.405.200-1_amd64.deb
ENV SA_PASSWORD=visa_123
ENV ACCEPT_EULA=Y
ENV container=docker
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN set -xe \
    && apt-get update \
    && apt-get install -y \
        curl \
    && rm -rf /var/lib/apt/lists/* \
    && curl -sSL https://packages.microsoft.com/ubuntu/16.04/mssql-server/pool/main/m/mssql-server-agent/${SQL_SERVER_AGENT} -o /tmp/mssql-server-agent.deb \
    && dpkg-deb -x /tmp/mssql-server-agent.deb /tmp/t1 \
    && mv /tmp/t1/opt/mssql/lib/sqlagent.sfp /opt/mssql/lib/ \
    && rm -rf /tmp/t1 \
    && rm -rf /tmp/mssql-server-agent.deb

