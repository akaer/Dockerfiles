#!/usr/bin/env bash

set -ex

# global variables
SCRIPT_ARGS="$*"
SCRIPT_NAME="$0"
SCRIPT_NAME="${SCRIPT_NAME#\./}"
SCRIPT_NAME="${SCRIPT_NAME##/*/}"
SCRIPT_BASE_DIR="$(cd "$( dirname "$0")" && pwd )"

install_json_gem() {
    echo -e "\ngem 'json'" >> Gemfile
    echo "Added json's explicit dependency on Gemfile."
}

install_widgets() {
    local WIDGETS=${@}

    if [[ ! -z "${WIDGETS}" ]]; then
        for WIDGET in ${WIDGETS}; do
            echo  "Installing widget from gist ${WIDGET}"
            smashing install "${WIDGET}"
        done
    fi
}

install_gems() {
    local GEMS=${@}

    if [[ ! -z "${GEMS}" ]]; then
        echo "Installing gem(s): ${GEMS}"
        for GEM in ${GEMS}; do
            echo -e "\ngem '${GEM}'" >> Gemfile
        done
        bundle install
        ldconfig
    fi
}

if [[ ! -e /installed ]]; then
    install_json_gem
    install_widgets ${WIDGETS}
    install_gems ${GEMS}
    touch /installed
fi

exec smashing start -p 3030

