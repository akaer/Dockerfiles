#!/usr/bin/env bash

set -ex

sudo docker run -it --rm --name latex --user="$(id -u):$(id -g)" --net=none -v $(pwd):/data -v /etc/localtime:/etc/localtime:ro akaer/latex "$@"

