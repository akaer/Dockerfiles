#
# Docker image for
#
# Microsoft SQL Server 2019 simple configuration
#
#
# Create:
#
#  sudo docker build --rm -t akaer/mssql-server-2019-simple . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run --rm=true -it \
#       --name mssql-server-2019-simple \
#       -p 1433:1433 \
#       -v $(pwd)/backups:/backups:rw \
#       -h sqlserver1 \
#       akaer/mssql-server-2019-simple
#
# ⚠ Hint
# If you have to run as root use "-u 0:0" instead
#

FROM mcr.microsoft.com/mssql/server:2019-latest
LABEL maintainer "André Raabe <andre.raabe@gmail.com>"

ENV TZ=Europe/Berlin
ENV SA_PASSWORD=P@ssw0rd
ENV MSSQL_PID=Developer
ENV MSSQL_ENABLE_HADR=0
ENV MSSQL_AGENT_ENABLED=false
ENV ACCEPT_EULA=Y
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV DEBIAN_FRONTEND noninteractive

COPY mssql.conf /var/opt/mssql/mssql.conf

USER root

RUN set -xe \
    && apt-get update \
    && apt-get upgrade -q -y \
    && rm -rf /var/lib/apt/lists/*

USER mssql
