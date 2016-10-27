#
# Docker image for
#
# Jenkins
#
#
# Create:
#
# sudo docker build --rm -t akaer/jenkins . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run -d --restart='always' \
#       --name jenkins \
#       -v /etc/localtime:/etc/localtime:ro \
#       -p 8080:8080 -p 50000:50000 \
#       --env JAVA_OPTS="-Djava.awt.headless=true -Duser.timezone=Europe/Berlin -Xmx512m -XX:PermSize=512m -XX:MaxPermSize=1024m -Xms512m -Djava.net.preferIPv4Stack=true -Djenkins.install.state=INITIAL_SETUP_COMPLETED" \
#       -v /var/jenkins_home \
#       akaer/jenkins
#
#
#
# Hints:
#
# http://javadoc.jenkins-ci.org/jenkins/install/InstallState.html
#
# --> -Djenkins.install.state=INITIAL_SETUP_COMPLETED
#


FROM jenkins:alpine
MAINTAINER André Raabe <andre.raabe@gmail.com>

RUN set -xe \
    && install-plugins.sh \
        active-directory \
        build-monitor-plugin \
        build-name-setter \
        categorized-view \
        conditional-buildstep \
        docker-workflow \
        envinject \
        git \
        git-client \
        icon-shim \
        jenkins-multijob-plugin \
        modernstatus \
        msbuild \
        nunit \
        parameterized-trigger \
        rebuild \
        scriptler \
        subversion \
        swarm \
        timestamper \
        vsphere-cloud \
        windows-slaves \
        workflow-aggregator

