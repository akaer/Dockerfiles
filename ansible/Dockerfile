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
LABEL maintainer "André Raabe <andre.raabe@gmail.com>"

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
        python3-dev \
        make \
        ' \
    && apk update \
    && apk add --no-cache \
        ca-certificates \
        coreutils \
        curl \
        krb5 \
        krb5-libs \
        python3 \
        py3-httplib2 \
        py3-jinja2 \
        py3-paramiko \
        py3-yaml \
        util-linux \
        ${builddeps} \
    && python3 -m ensurepip \
    && pip3 install --upgrade pip \
    && rm -r /usr/lib/python*/ensurepip \
    && pip3 install --upgrade \
        ansible \
        httplib2 \
        jinja2 \
        kerberos \
        markupsafe \
        paramiko \
        pip \
        pysphere \
        PyVmomi \
        pywinrm \
        setuptools \
        six \
        xmltodict \
    && rm -r /root/.cache \
    && apk del --no-cache --verbose --purge make gcc \
    && rm -rf /var/cache/apk/*

USER $ANSIBLE_USER

CMD [ "ansible", "--version" ]

