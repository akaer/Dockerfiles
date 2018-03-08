#
# Docker image for
#
# Microsoft SQL Server with mono
#
#
# Create:
#
#  sudo docker build --rm -t akaer/mssql-server-mono-linux . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run --rm=true -it \
#       --name mssql-server-mono-linux \
#       -p 1433:1433 \
#       -v /etc/localtime:/etc/localtime:ro \
#       -v $(pwd)/t1:/var/opt/mssql \
#       -h sqlserver1 \
#       akaer/mssql-server-mono-linux
#
#

FROM microsoft/mssql-server-linux:2017-latest
LABEL maintainer "André Raabe <andre.raabe@gmail.com>"

ENV SQL_SERVER_AGENT mssql-server-agent_14.0.3015.40-1_amd64.deb
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
    && curl -sSL https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-agent/${SQL_SERVER_AGENT} -o /tmp/mssql-server-agent.deb \
    && dpkg-deb -x /tmp/mssql-server-agent.deb /tmp/t1 \
    && mv /tmp/t1/opt/mssql/lib/sqlagent.sfp /opt/mssql/lib/ \
    && rm -rf /tmp/t1 \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
    && echo "deb http://download.mono-project.com/repo/ubuntu stable-xenial main" | tee /etc/apt/sources.list.d/mono-official-stable.list \
    && apt-get update \
    && apt-get install -y \
        mono-devel \
        mono-complete \
        ca-certificates-mono \
        libmono-microsoft-visualbasic10.0-cil \
        vim \
        less \
    && ln -s /usr/bin/vbc /usr/bin/vbnc
    && rm -rf /tmp/mssql-server-agent.deb \
    && rm -rf /var/lib/apt/lists/*

