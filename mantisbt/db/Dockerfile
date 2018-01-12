#
# Docker image for
#
# mysql for mantisbt
#
#
# Create:
#
# sudo docker build --rm -t mantisbt-mysql . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run --rm=true -it \
#   --name mantisbt-mysql \
#   -v /etc/localtime:/etc/localtime:ro \
#   -v $(pwd):/data \
#   akaer/mantisbt-mysql
#
#
FROM mysql
LABEL maintainer "André Raabe <andre.raabe@gmail.com>"

ADD files/schema.sql /docker-entrypoint-initdb.d

