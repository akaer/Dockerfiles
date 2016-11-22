#
# Docker image for
#
# mysql for Guacamole
#
#
# Create:
#
# sudo docker build --rm -t guac-mysql . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run --rm=true -it \
#   --name guac-mysql \
#   -v /etc/localtime:/etc/localtime:ro \
#   -v $(pwd):/data \
#   akaer/guac-mysql
#
#
FROM mysql
MAINTAINER André Raabe <andre.raabe@gmail.com>

ADD files/initdb.sql /docker-entrypoint-initdb.d

