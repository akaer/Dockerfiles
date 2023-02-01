#
# Docker image for
#
# Microsoft SQL Server 2017
#
#
# Create:
#
#  sudo docker build --rm -t akaer/mssql-server-2017-linux . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run --rm=true -it \
#       --name mssql-server-2017-linux \
#       -p 1433:1433 \
#       -p 135:135 \
#       -p 51999:51999 \
#       -v $(pwd)/backups:/backups:rw \
#       -h sqlserver1 \
#       akaer/mssql-server-2017-linux
#
# ⚠ Hint
# If you need persistent data that add -v sqldata:/var/opt/mssql
# To use tmpfs as storage, specify -e LD_PRELOAD=/root/nodirect_open.so
#

FROM mcr.microsoft.com/mssql/server:2017-latest
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
ADD nodirect_open.c /tmp

RUN set -xe \
    && apt-get update \
    && apt-get upgrade -q -y \
    && apt-get install -q -y gcc \
    && mkdir -p /var/opt/mssql \
    && cp /tmp/mssql.conf /var/opt/mssql/mssql.conf \
    && cc -shared -fpic -o /root/nodirect_open.so /tmp/nodirect_open.c -ldl \
    && apt purge -y gcc \
    && rm -rf /var/lib/apt/lists/*
#    && echo '/root/nodirect_open.so' >> /etc/ld.so.preload

HEALTHCHECK --interval=15s --timeout=3s --start-period=30s --retries=10 \
    CMD /opt/mssql-tools/bin/sqlcmd -S localhost -U ${DATABASE_USER} -P ${SA_PASSWORD} -d tempdb -Q "SELECT 1" || exit 1
