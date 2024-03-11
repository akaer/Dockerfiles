#
# Docker image for
#
# Microsoft SQL Server 2022
#
#
# Create:
#
#  sudo docker build --rm -t akaer/mssql-server-2022 . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run -d --restart=always \
#       --name db1 \
#       --hostname db1 \
#       --shm-size 1g \
#       -e TZ=Europe/Berlin \
#       -p 1433:1433 \
#       -v db1_backup:/backup:rw \
#       -v db1_data:/var/opt/mssql \
#       akaer/mssql-server-2022
#
# or for possible cluster solutions
#
#  sudo docker run -d --restart=always \
#       --name db1 \
#       --hostname db1 \
#       --shm-size 1g \
#       -e TZ=Europe/Berlin \
#       -p 10001:1433 \
#       -p 20001:5022 \
#       -p 30001:135 \
#       -p 40001:51000 \
#       -v db_backup:/backup:rw \
#       -v db1_data:/var/opt/mssql \
#       -v db_shared:/var/opt/mssql/shared \
#       akaer/mssql-server-2022
#
# ⚠ Hint
# If you have to run as root use "-u 0:0" instead
# If you need persistent data that add -v sqldata:/var/opt/mssql
#

FROM mcr.microsoft.com/mssql/server:2022-latest
LABEL maintainer "André Raabe <andre.raabe@gmail.com>"

ENV ACCEPT_EULA=Y
ENV DATABASE_USER=sa
ENV DEBIAN_FRONTEND=noninteractive
ENV DOTNET_CLI_TELEMETRY_OPTOUT=1
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8
ENV MSSQL_AGENT_ENABLED=true
ENV MSSQL_ENABLE_HADR=1
ENV MSSQL_PID=Developer
ENV POWERSHELL_TELEMETRY_OPTOUT=1
ENV SA_PASSWORD=P@ssw0rd
ENV TZ=Europe/Berlin
ENV DATABASE_MEMORYLIMITMB 4096

COPY ./mssql.conf /tmp/mssql.conf
COPY ./*.sh /tmp/
COPY ./*.sql /tmp/

HEALTHCHECK --interval=15s --timeout=3s --start-period=30s --retries=10 \
    CMD /opt/mssql-tools/bin/sqlcmd -S localhost -U "${DATABASE_USER}" -P "${SA_PASSWORD}" -d tempdb -Q 'SELECT 1' || exit 1

USER root

RUN set -xe \
    && apt-get update \
    && apt-get full-upgrade -q -y \
    && apt-get install -q -y \
        apt-transport-https \
        curl \
        dnsutils \
        dotnet-runtime-8.0 \
        iproute2 \
        iputils-ping \
        net-tools \
        powershell \
        sqlcmd \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /backup \
    && mkdir -p /home/mssql \
    && mkdir -p /var/opt/mssql/shared \
    && mkdir -p /ssl \
    && chmod +x /tmp/*.sh \
    && openssl rand -writerand /root/.rnd \
    && cp -iv /root/.rnd /home/mssql/.rnd \
    && chown -R mssql /backup /home/mssql /var/opt/mssql /ssl

USER mssql

RUN set -xe \
    && pwsh -NoLogo -NonInteractive -NoProfile -Command 'Install-Module -Name SqlServer,Pester,PsWriteHTML,PSScriptAnalyzer,dbatools -Scope CurrentUser -Force -AcceptLicense -ErrorAction Stop'

USER root

CMD /bin/bash /tmp/entrypoint.sh
