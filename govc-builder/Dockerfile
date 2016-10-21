#
# https://github.com/vmware/govmomi/tree/master/govc
#
# govc is a vSphere CLI built on top of govmomi.
#
#
# Docker image for
#
# govc-builder (Image to build govc)
#
#
# Create:
#
# sudo docker build --rm -t akaer/govc-builder . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run --rm=true -it \
#  -v $(pwd):/data akaer/govc-builder
#

FROM golang:alpine
MAINTAINER André Raabe <andre.raabe@gmail.com>

ENV GOVC_VERSION v0.10.0

RUN set -ex \
    && apk add --no-cache \
        bash \
        ca-certificates \
        git \
        make \
    && rm -rf /var/cache/apk/* \
    && update-ca-certificates

RUN set -ex \
    && export GOPATH=${HOME}/govmomi \
    && go get github.com/vmware/govmomi \
    && cd ${GOPATH}/src/github.com/vmware/govmomi \
    && git checkout tags/${GOVC_VERSION} \
    && CGO_ENABLED=0 make install \
    && cp ${GOPATH}/bin/govc /usr/bin \
    && rm -rf ${HOME}/govmomi

CMD [ "cp", "/usr/bin/govc", "/data" ]
