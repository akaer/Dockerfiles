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

replace_vars /tmp/mssql.conf
cp -iv /tmp/mssql.conf /var/opt/mssql/mssql.conf

openssl req -x509 -nodes -newkey rsa:4096 \
    -subj '/CN='${HOSTNAME} \
    -keyout "/tmp/ssl/${HOSTNAME}_mssql.key" \
    -out "/tmp/ssl/${HOSTNAME}_mssql.pem" -days 365

echo "[*] Pre customizing sql server done"

exit 0
