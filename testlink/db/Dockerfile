#
# Docker image for
#
# mysql for testlink
#
#
# Create:
#
# sudo docker build --rm -t testlink-mysql . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run --rm=true -it \
#   --name testlink-mysql \
#   -v /etc/localtime:/etc/localtime:ro \
#   -v $(pwd):/data \
#   akaer/testlink-mysql
#
#
FROM mysql
LABEL maintainer "André Raabe <andre.raabe@gmail.com>"

ADD files/1-schema.sql /docker-entrypoint-initdb.d
ADD files/2-data.sql /docker-entrypoint-initdb.d
