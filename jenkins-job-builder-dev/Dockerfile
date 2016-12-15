#
# Docker image for
#
# Jenkins Job Builder (http://docs.openstack.org/infra/jenkins-job-builder/)
#
#
# Create:
#
# sudo docker build --rm -t akaer/jjb-dev . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run -i --rm \
#       --name jjb-dev \
#       -v /etc/localtime:/etc/localtime:ro \
#       -v $(pwd):/data:ro \
#       akaer/jjb-dev
#

FROM akaer/python
MAINTAINER André Raabe <andre.raabe@gmail.com>

RUN set -ex \
    && apk update \
    && apk add --no-cache \
        git \
    && rm -rf /var/cache/apk/* \
    && git clone https://git.openstack.org/openstack-infra/jenkins-job-builder \
    && cd jenkins-job-builder \
    && pip install -r requirements.txt \
    && python setup.py build \
    && python setup.py install \
    && cd ..\
    && rm -rf jenkins-job-builder

VOLUME /data
WORKDIR /data

ENTRYPOINT [ "jenkins-jobs", "--conf", "/data/jenkins_jobs.ini" ]

