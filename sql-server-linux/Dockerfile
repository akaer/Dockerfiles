#
# Docker image for
#
# Microsoft SQL Server
#
#
# Create:
#
#  sudo docker build --rm -t akaer/mssql-server-linux . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run --rm=true -it \
#       --name mssql-server-linux \
#       -p 1433:1433 \
#       -v /etc/localtime:/etc/localtime:ro \
#       -v $(pwd)/data:/var/opt/mssql:rw \
#       -h sqlserver1 \
#       akaer/mssql-server-linux
#
#

FROM mcr.microsoft.com/mssql/server:2017-latest
LABEL maintainer "André Raabe <andre.raabe@gmail.com>"

ENV SA_PASSWORD=visa_123
ENV MSSQL_PID=Developer
#ENV MSSQL_ENABLE_HADR=1
#ENV MSSQL_AGENT_ENABLED=true
ENV ACCEPT_EULA=Y
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

