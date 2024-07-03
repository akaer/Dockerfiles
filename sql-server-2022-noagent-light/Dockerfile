#
# Docker image for
#
# Microsoft SQL Server 2022 without SQL Server Agent configuration
#
#
# Create:
#
#  sudo docker build --rm -t akaer/mssql-server-2022-noagent-light . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run -d --restart=always \
#       --name db1 \
#       --hostname db1 \
#       --shm-size 1g \
#       -e TZ=Europe/Berlin \
#       -p 1433:1433 \
#       -v db1_backups:/backups:rw \
#       -v db1_data:/var/opt/mssql \
#       akaer/mssql-server-2022-noagent-light
#
# ⚠ Hint
# If you have to run as root use "-u 0:0" instead
# If you need persistent data that add -v sqldata:/var/opt/mssql
#

FROM mcr.microsoft.com/mssql/server:2022-latest
LABEL maintainer="André Raabe <andre.raabe@gmail.com>"

ENV ACCEPT_EULA=Y
ENV DATABASE_USER=sa
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8
ENV MSSQL_AGENT_ENABLED=false
ENV MSSQL_ENABLE_HADR=0
ENV MSSQL_PID=Developer
ENV SA_PASSWORD=P@ssw0rd
ENV TZ=Europe/Berlin

COPY mssql.conf /var/opt/mssql/mssql.conf
COPY entrypoint.sh /tmp/entrypoint.sh
COPY configure_sqlserver.sh /tmp/configure_sqlserver.sh
COPY ./*.sql /tmp/

USER root

RUN set -xe \
    && apt-get update \
    && apt-get install -q -y \
        sqlcmd \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /backups \
    && chown mssql /backups

HEALTHCHECK --interval=15s --timeout=3s --start-period=30s --retries=10 \
    CMD /opt/mssql-tools/bin/sqlcmd -S localhost -U "${DATABASE_USER}" -P "${SA_PASSWORD}" -d tempdb -Q 'SELECT 1' || exit 1

CMD /bin/bash /tmp/entrypoint.sh

