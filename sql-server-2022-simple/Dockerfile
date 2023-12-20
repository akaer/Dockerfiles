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
#       --shm-size 1g \
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

ENV ACCEPT_EULA Y
ENV TZ=Europe/Berlin
ENV DATABASE_USER sa
ENV SA_PASSWORD=P@ssw0rd
ENV MSSQL_PID=Developer
ENV MSSQL_ENABLE_HADR=0
ENV MSSQL_AGENT_ENABLED=false
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8
ENV DEBIAN_FRONTEND=noninteractive
ENV DOTNET_CLI_TELEMETRY_OPTOUT=1
ENV POWERSHELL_TELEMETRY_OPTOUT=1

COPY mssql.conf /var/opt/mssql/mssql.conf
COPY entrypoint.sh /tmp/entrypoint.sh
COPY configure_sqlserver.sh /tmp/configure_sqlserver.sh
COPY ./*.sql /tmp/

USER root

RUN set -xe \
    && apt-get update \
    && apt-get full-upgrade -q -y \
    && apt-get install -q -y \
        curl \
        apt-transport-https \
        sqlcmd \
        powershell \
        dotnet-runtime-8.0 \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /home/mssql \
    && chown mssql /home/mssql

USER mssql

RUN set -xe \
    && pwsh -NoLogo -NonInteractive -NoProfile -Command 'Install-Module -Name SqlServer,Pester,PsWriteHTML,PSScriptAnalyzer -Scope CurrentUser -Force'

HEALTHCHECK --interval=15s --timeout=3s --start-period=30s --retries=10 \
    CMD /opt/mssql-tools/bin/sqlcmd -S localhost -U "${DATABASE_USER}" -P "${SA_PASSWORD}" -d tempdb -Q 'SELECT 1' || exit 1

CMD /bin/bash /tmp/entrypoint.sh
