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
#  sudo docker run --rm=true -it \
#       --name jjb \
#       -v /etc/localtime:/etc/localtime:ro \
#       -v $(pwd):/opt/jenkins-jobs:ro \
#       akaer/jjb
#

FROM akaer/python
MAINTAINER André Raabe <andre.raabe@gmail.com>

RUN set -ex \
    && pip install jenkins-job-builder \
    && mkdir -p /opt/jenkins-job \
    && rm -f /etc/jenkins_jobs/jenkins_jobs.ini

VOLUME /opt/jenkins-job
WORKDIR /opt/jenkins-job

ENTRYPOINT [ "jenkins-jobs" ]

