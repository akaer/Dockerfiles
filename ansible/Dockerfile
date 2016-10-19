#
# Docker image for
#
# ansible
#
#
# Create:
#
# sudo docker build --rm -t akaer/ansible . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run --rm=true -it \
#       --name ansible \
#       -v ${PWD}/hosts:/etc/ansible/hosts \
#       -v ${PWD}/ansible.cfg:/etc/ansible/ansible.cfg \
#       -v ${HOME}/.ssh:/root/.ssh:ro \
#       -v /etc/localtime:/etc/localtime:ro \
#       akaer/ansible
#

FROM akaer/base
MAINTAINER André Raabe <andre.raabe@gmail.com>

ENV ANSIBLE_USER ansi
ENV ANSIBLE_HOME /home/${ANSIBLE_USER}

RUN set -xe \
    && adduser -S -h ${ANSIBLE_HOME} -g "${ANSIBLE_USER} user" ${ANSIBLE_USER} \
    && chown -R ${ANSIBLE_USER} ${ANSIBLE_HOME}

RUN set -xe \
    && builddeps=' \
        gcc \
        krb5-dev \
        libffi-dev \
        musl-dev \
        openssl-dev \
        py-pip \
        python-dev \
        ' \
    && apk update \
    && apk add --no-cache \
        ca-certificates \
        curl \
        coreutils \
        util-linux \
        py-paramiko \
        py-yaml \
        py-jinja2 \
        py-httplib2 \
        krb5 \
        krb5-libs \
        ${builddeps} \
    && python -m ensurepip \
    && rm -r /usr/lib/python*/ensurepip \
    && pip install --upgrade \
        pip \
        setuptools \
        ansible \
        httplib2 \
        jinja2 \
        kerberos \
        markupsafe \
        paramiko \
        pysphere \
        PyVmomi \
        pywinrm \
        PyYAML \
        six \
        xmltodict \
    && apk del --purge ${builddeps} \
    && rm -r /root/.cache \
    && rm -rf /var/cache/apk/*

USER $ANSIBLE_USER

CMD [ "ansible", "--version" ]

