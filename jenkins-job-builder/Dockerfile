#
# Docker image for
#
# Jenkins Job Builder (http://docs.openstack.org/infra/jenkins-job-builder/)
#
#
# Create:
#
# sudo docker build --rm -t akaer/jjb . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run -i --rm \
#       --name jjb \
#       -v /etc/localtime:/etc/localtime:ro \
#       -v $(pwd):/data:ro \
#       akaer/jjb
#

FROM akaer/python3
LABEL maintainer "André Raabe <andre.raabe@gmail.com>"

RUN set -ex \
    && pip3 install jenkins-job-builder

VOLUME /data
WORKDIR /data

ENTRYPOINT [ "jenkins-jobs", "--conf", "/data/jenkins_jobs.ini" ]

