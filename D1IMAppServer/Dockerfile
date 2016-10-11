#
# Docker image for
#
# D1IM AppServer
#
#
# Create:
#
# sudo docker build -t akaer/d1imappserver . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run --rm=true -it \
#   --name AppServer \
#   --dns 10.10.206.206 \
#   -v /etc/localtime:/etc/localtime:ro \
#   -v $(pwd):/var/www \
#   -p 30000:80 \
#   akaer/d1imappserver
#

FROM mono
MAINTAINER André Raabe <andre.raabe@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8

RUN set -xe \
    && apt-get update -y \
    && apt-get install -y \
        apache2 \
        libapache2-mod-mono \
        mono-apache-server4 \
        mono-complete \
        mono-vbnc \
    && rm -rf /var/lib/apt/lists/*

RUN set -xe \
    && chmod 777 /etc/mono \
    && mkdir -p /usr/share/.mono \
    && chmod 777 /usr/share/.mono \
    && service apache2 stop \
    && sed -ri.bak ' \
        s!^(\s*CustomLog)\s+\S+!\1 /proc/self/fd/1!g; \
        s!^(\s*ErrorLog)\s+\S+!\1 /proc/self/fd/2!g; \
        ' /etc/apache2/apache2.conf

ADD files/run.sh /tmp/run.sh
ADD files/apache2-site.conf /etc/apache2/sites-available/default

VOLUME /var/www

EXPOSE 80

CMD [ "/tmp/run.sh" ]

