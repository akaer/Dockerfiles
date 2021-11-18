#
# Docker image for
#
# Microsoft SQL Server 2017
#
#
# Create:
#
#  sudo docker build --rm -t akaer/mssql-server-2017 . 2>&1 |tee docker_build.log
#
# Run:
#
#  Server 1 - db1
#
#  sudo docker run --rm=true -it \
#       --name mssql-server-2017-db1 \
#       -p 10000:1444 \
#       -p 10001:1433 \
#       -p 20001:5022 \
#       -p 30001:135 \
#       -p 40001:51000 \
#       -v $(pwd)/backup:/backup:rw \
#       -v shared:/var/opt/mssql/shared \
#       -h db1 \
#       akaer/mssql-server-2017
#
#  Server 2 - db2
#
#  sudo docker run --rm=true -it \
#       --name mssql-server-2017-db2 \
#       -p 10002:1433 \
#       -p 20002:5022 \
#       -p 30002:135 \
#       -p 40002:51000 \
#       -v $(pwd)/backup:/backup:rw \
#       -v shared:/var/opt/mssql/shared \
#       -h db2 \
#       akaer/mssql-server-2017
#
FROM mcr.microsoft.com/mssql/server:2017-latest
LABEL maintainer "André Raabe <andre.raabe@gmail.com>"

ENV DATABASE_USER sa
ENV SA_PASSWORD P@ssw0rd
ENV MSSQL_PID Developer
ENV MSSQL_ENABLE_HADR 1
ENV MSSQL_AGENT_ENABLED true
ENV MSSQL_RPC_PORT 135
ENV MSSQL_DTC_TCP_PORT 51000
ENV ACCEPT_EULA Y
ENV DATABASE_MEMORYLIMITMB 4096
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV TZ Europe/Berlin
ENV DEBIAN_FRONTEND noninteractive

COPY ./*.inc /tmp/
COPY ./*.sh /tmp/
COPY ./*.sql /tmp/
COPY ./mssql.conf /tmp/mssql.conf

RUN set -ex \
    && chmod +x /tmp/*.sh \
    && apt-get update \
    && apt-get install -q -y \
        net-tools \
    && apt-get upgrade -q -y \
    && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/* \
    && openssl rand -out /root/.rnd 4711 \
    && mkdir -p /tmp/ssl \
    && mkdir -p /var/opt/mssql/shared

HEALTHCHECK --interval=10s --timeout=3s --start-period=60s --retries=10 \
    CMD /opt/mssql-tools/bin/sqlcmd -S localhost -U ${DATABASE_USER} -P ${SA_PASSWORD} -d tempdb -Q "SELECT 1" || exit 1

CMD /bin/bash /tmp/entrypoint.sh
