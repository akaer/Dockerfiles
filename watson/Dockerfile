#
# Docker image for
#
# watson (http://tailordev.github.io/Watson)
#
#
# Create:
#
# sudo docker build --rm -t akaer/watson . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run --rm=true -it \
#       --name watson \
#       --user="$(id -u):$(id -g)" \
#       -v /etc/localtime:/etc/localtime:ro \
#       -v $(pwd)/watson_data:/watson_data \
#       -v $(pwd)/watson_config:/.config/watson \
#       akaer/watson
#

FROM akaer/python3
MAINTAINER André Raabe <andre.raabe@gmail.com>

ENV WATSON_DIR /watson_data

RUN set -xe \
    && pip install --verbose td-watson

VOLUME [ "/watson_data" ]
ENTRYPOINT [ "/usr/bin/watson" ]
CMD [ "--version" ]

