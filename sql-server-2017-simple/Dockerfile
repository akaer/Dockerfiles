#
# Docker image for
#
# Microsoft SQL Server 2017 simple configuration
#
#
# Create:
#
#  sudo docker build --rm -t akaer/mssql-server-2017-linux-simple . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run --rm=true -it \
#       --name mssql-server-2017-linux-simple \
#       -p 1433:1433 \
#       -v $(pwd)/backups:/backups:rw \
#       -h sqlserver1 \
#       akaer/mssql-server-2017-linux-simple
#

FROM mcr.microsoft.com/mssql/server:2017-latest
LABEL maintainer "André Raabe <andre.raabe@gmail.com>"

ENV TZ=Europe/Berlin
ENV SA_PASSWORD=P@ssw0rd
ENV MSSQL_PID=Developer
ENV ACCEPT_EULA=Y
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

COPY mssql.conf /var/opt/mssql/mssql.conf
