#
# Docker image for
#
# govc (https://github.com/vmware/govmomi/tree/master/govc)
#
# govc is a vSphere CLI built on top of govmomi.
#
#
# Create:
#
# sudo docker build --rm -t akaer/govc . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run --rm=true -it \
#  --name govc \
#  -v /etc/localtime:/etc/localtime:ro \
#  -v $(pwd):/data akaer/govc
#

FROM alpine:latest
LABEL maintainer "André Raabe <andre.raabe@gmail.com>"

ENV GOVC_INSECURE true
ENV GOVC_URL https://user:password@vsphere-ip-or-hostname/sdk
ENV GOVC_DATACENTER VCENTER-NAME

RUN set -xe \
    && wget -q https://github.com/vmware/govmomi/releases/download/v0.20.0/govc_linux_amd64.gz \
    && gunzip govc_linux_amd64.gz \
    && mv govc_linux_amd64 /usr/bin/govc \
    && chmod +x /usr/bin/govc

ENTRYPOINT [ "/usr/bin/govc" ]
CMD [ "version" ]

