#!/usr/bin/env bash

set -e

[[ -n "${DEBUG}" ]] && set -x

# global variables
SCRIPT_ARGS="$*"
SCRIPT_NAME="$0"
SCRIPT_NAME="${SCRIPT_NAME#\./}"
SCRIPT_NAME="${SCRIPT_NAME##/*/}"
SCRIPT_BASE_DIR="$(cd "$( dirname "$0")" && pwd )"


download_file() {
    local -r file="${1:?"err: Missing file"}"; shift

    if [[ ! -e "${file}" ]]; then
        curl -sSLO "${file}"
    fi
}

download_file "http://nasdd01.vi.lan/cifs/ISO/Oracle/Instantclient/Linux/12.1.0.2.0/64Bit/instantclient-basiclite-linux.x64-12.1.0.2.0.zip"
download_file "http://nasdd01.vi.lan/cifs/ISO/Oracle/Instantclient/Linux/12.1.0.2.0/64Bit/instantclient-sdk-linux.x64-12.1.0.2.0.zip"
download_file "http://nasdd01.vi.lan/cifs/ISO/Oracle/Instantclient/Linux/12.1.0.2.0/64Bit/instantclient-sqlplus-linux.x64-12.1.0.2.0.zip"

