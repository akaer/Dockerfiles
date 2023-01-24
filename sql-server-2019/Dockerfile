#
# Docker image for
#
# Microsoft SQL Server 2019
#
#
# Create:
#
#  sudo docker build --rm -t akaer/mssql-server-2019 . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run --rm=true -it \
#       --name mssql-server-2019-linux \
#       -p 1433:1433 \
#       -p 135:135 \
#       -p 51999:51999 \
#       -v $(pwd)/backups:/backups:rw \
#       -h sqlserver1 \
#       akaer/mssql-server-2019
#
# ⚠ Hint
# If you have to run as root use "-u 0:0" instead
# If you need persistent data that add -v sqldata:/var/opt/mssql
#

FROM mcr.microsoft.com/mssql/server:2019-latest
LABEL maintainer "André Raabe <andre.raabe@gmail.com>"

ENV TZ=Europe/Berlin
ENV DATABASE_USER=sa
ENV SA_PASSWORD=P@ssw0rd
ENV MSSQL_PID=Developer
ENV MSSQL_ENABLE_HADR=1
ENV MSSQL_AGENT_ENABLED=true
ENV ACCEPT_EULA=Y
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

COPY mssql.conf /tmp/mssql.conf

USER root

RUN set -xe \
    && apt-get update \
    && apt-get upgrade -q -y \
    && rm -rf /var/lib/apt/lists/* \
    && cp /tmp/mssql.conf /var/opt/mssql/mssql.conf

USER mssql

HEALTHCHECK --interval=15s --timeout=3s --start-period=30s --retries=10 \
    CMD /opt/mssql-tools/bin/sqlcmd -S localhost -U ${DATABASE_USER} -P ${SA_PASSWORD} -d tempdb -Q "SELECT 1" || exit 1
