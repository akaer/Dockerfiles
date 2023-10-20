#
# Docker image for
#
# Microsoft SQL Server 2022 simple configuration
#
#
# Create:
#
#  sudo docker build --rm -t akaer/mssql-server-2022-simple . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run --rm --restart=always \
#       --name db1 \
#       --hostname db1 \
#       -e TZ=Europe/Berlin \
#       -p 1433:1433 \
#       -v db1_backups:/backups:rw \
#       -v db1_data:/var/opt/mssql \
#       akaer/mssql-server-2022-simple
#
# ⚠ Hint
# If you have to run as root use "-u 0:0" instead
#

FROM mcr.microsoft.com/mssql/server:2022-latest
LABEL maintainer "André Raabe <andre.raabe@gmail.com>"

ENV TZ=Europe/Berlin
ENV SA_PASSWORD=P@ssw0rd
ENV MSSQL_PID=Developer
ENV MSSQL_ENABLE_HADR=0
ENV MSSQL_AGENT_ENABLED=false
ENV ACCEPT_EULA=Y
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

COPY mssql.conf /var/opt/mssql/mssql.conf

USER root

RUN set -xe \
    && apt-get update \
    && apt-get upgrade -q -y \
    && rm -rf /var/lib/apt/lists/*

USER mssql

HEALTHCHECK --interval=15s --timeout=3s --start-period=30s --retries=10 \
    CMD /opt/mssql-tools/bin/sqlcmd -S localhost -U 'sa' -P "${SA_PASSWORD}" -d tempdb -Q 'SELECT 1' || exit 1
