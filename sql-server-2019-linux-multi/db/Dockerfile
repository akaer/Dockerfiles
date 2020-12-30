FROM mcr.microsoft.com/mssql/server:2019-latest
LABEL maintainer "André Raabe <andre.raabe@gmail.com>"

ENV DATABASE_USER=sa
ENV SA_PASSWORD=P@ssw0rd
ENV MSSQL_PID=Developer
ENV MSSQL_ENABLE_HADR=1
ENV MSSQL_AGENT_ENABLED=true
ENV ACCEPT_EULA=Y
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV DEBIAN_FRONTEND noninteractive

USER root

COPY ./*.inc /tmp/
COPY ./*.sh /tmp/
COPY ./*.sql /tmp/
COPY ./mssql.conf /tmp/mssql.conf

RUN set -ex \
    && chmod +x /tmp/*.sh \
    && chown mssql /tmp/*.sql /tmp/*.sh /tmp/mssql.conf \
    && apt-get update \
    && apt-get install -q -y \
        net-tools \
    && apt-get upgrade -q -y \
    && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/*

USER mssql

HEALTHCHECK --interval=15s --timeout=3s --start-period=30s --retries=10 \
    CMD /opt/mssql-tools/bin/sqlcmd -S localhost -U ${DATABASE_USER} -P ${SA_PASSWORD} -Q "SELECT 1" || exit 1

CMD /bin/bash /tmp/entrypoint.sh
