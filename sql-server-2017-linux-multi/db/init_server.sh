#!/usr/bin/env bash

set -Eeuo pipefail

# global variables
SCRIPT_ARGS="$@"
SCRIPT_NAME="$0"
SCRIPT_NAME="${SCRIPT_NAME#\./}"
SCRIPT_NAME="${SCRIPT_NAME##/*/}"
SCRIPT_BASE_DIR="$(cd "$( dirname "$0")" && pwd )"

[[ -e "${SCRIPT_BASE_DIR}/common.inc" ]] && source "${SCRIPT_BASE_DIR}/common.inc"

echo "[*] Pre customizing sql server"

cp -iv /tmp/mssql.conf /var/opt/mssql/mssql.conf
replace_vars /var/opt/mssql/mssql.conf

echo "[*] Pre customizing sql server done"

exit 0
