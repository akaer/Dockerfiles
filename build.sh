#!/usr/bin/env bash

set -e

[[ -n "${DEBUG}" ]] && set -x

# global variables
SCRIPT_ARGS="$*"
SCRIPT_NAME="$0"
SCRIPT_NAME="${SCRIPT_NAME#\./}"
SCRIPT_NAME="${SCRIPT_NAME##/*/}"
SCRIPT_BASE_DIR="$(cd "$( dirname "$0")" && pwd )"

set -u

build_image() {
    local -r imagedirectory="${1}"; shift
    local -r imagename="${1}"; shift

    pushd "${imagedirectory}"
    sudo docker build \
        --rm \
        -t "${imagename}" . 2>&1 | \
        tee docker_build_${imagedirectory}.log
    popd
}

docker_cleanup() {
    set +e
    sudo docker rm -f $(sudo docker ps -a -q) 2>&1
    sudo docker rmi $(sudo docker images -q) 2>&1
    sudo docker volume rm $(sudo docker volume ls -q) 2>&1
    sudo docker network rm $(sudo docker network ls -q) 2>&1
    set -e
}

docker_cleanup
build_image "base" "akaer/base"
build_image "Python2" "akaer/python"
build_image "Python3" "akaer/python3"
build_image "govc-builder" "akaer/govc-builder"
build_image "govc" "akaer/govc"
build_image "shellcheck" "akaer/shellcheck"
build_image "ssh-audit" "akaer/ssh-audit"
build_image "OpenDJ" "akaer/opendj"
build_image "Dokuwiki" "akaer/dokuwiki"
build_image "ansible" "akaer/ansible"
build_image "Openjre8" "akaer/openjre8"
#build_image "jupyter" "akaer/jupyter"
