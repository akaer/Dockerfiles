#!/bin/bash

set -Eeuo pipefail

# global variables
SCRIPT_ARGS="$@"
SCRIPT_NAME="$0"
SCRIPT_NAME="${SCRIPT_NAME#\./}"
SCRIPT_NAME="${SCRIPT_NAME##/*/}"
SCRIPT_BASE_DIR="$(cd "$( dirname "$0")" && pwd )"

(nohup /configure.sh >/dev/null 2>&1 &) \
&& /opt/opendj/run.sh
