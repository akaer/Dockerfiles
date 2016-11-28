#
# Docker image for
#
# mysql for Guacamole
#
#
# Create:
#
# sudo docker build --rm -t phpipam-mysql . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run --rm=true -it \
#   --name phpipam-mysql \
#   -v /etc/localtime:/etc/localtime:ro \
#   -v $(pwd):/data \
#   akaer/phpipam-mysql
#
#
FROM mysql
MAINTAINER André Raabe <andre.raabe@gmail.com>

ADD files/schema.sql /docker-entrypoint-initdb.d

