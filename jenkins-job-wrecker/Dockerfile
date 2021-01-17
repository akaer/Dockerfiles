#
# Docker image for
#
# Jenkins Job Wrecker (https://github.com/ktdreyer/jenkins-job-wrecker)
#
#
# Create:
#
# sudo docker build --rm -t akaer/jjw . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run -i --rm \
#       --name jjw \
#       -v /etc/localtime:/etc/localtime:ro \
#       -v $(pwd):/data \
#       akaer/jjw
#

FROM akaer/python3
LABEL maintainer "André Raabe <andre.raabe@gmail.com>"

RUN set -ex \
    && pip3 install jenkins-job-wrecker

VOLUME /data
WORKDIR /data

ENTRYPOINT [ "jjwrecker" ]

