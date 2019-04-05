#
# Docker image for
#
# Microsoft SQL Server
#
#
# Create:
#
#  sudo docker build --rm -t akaer/mssql-server-2019-linux . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run --rm=true -it \
#       --name mssql-server-2019-linux \
#       --dns 10.10.206.206 \
#       -p 1433:1433 \
#       -p 135:135 \
#       -p 51999:51999 \
#       -v /etc/localtime:/etc/localtime:ro \
#       -v $(pwd)/data:/var/opt/mssql:rw \
#       -v $(pwd)/backups:/backups:rw \
#       -h sqlserver1 \
#       akaer/mssql-server-2019-linux
#
#

FROM mcr.microsoft.com/mssql/server:2019-latest
LABEL maintainer "André Raabe <andre.raabe@gmail.com>"

ENV SA_PASSWORD=visa_123
ENV MSSQL_PID=Developer
ENV ACCEPT_EULA=Y
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

