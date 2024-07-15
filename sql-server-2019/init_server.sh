#!/usr/bin/env bash

set -Eeuo pipefail

# global variables
SCRIPT_ARGS="$@"
SCRIPT_NAME="$0"
SCRIPT_NAME="${SCRIPT_NAME#\./}"
SCRIPT_NAME="${SCRIPT_NAME##/*/}"
SCRIPT_BASE_DIR="$(cd "$( dirname "$0")" && pwd )"

replace_vars() {
    local -r DSTFILE="${1:-unset}"; shift

    sed -i -e "s|@@HOSTNAME@@|${HOSTNAME}|g" \
           -e "s|@@DATABASE_MEMORYLIMITMB@@|${DATABASE_MEMORYLIMITMB}|g" \
        "${DSTFILE}"
}

if [[ -e /var/opt/mssql/configure_done ]]; then
    echo "Skip SQL Server customization because it's already done"
    exit 0
fi

echo "[*] Pre customizing sql server"

replace_vars /tmp/mssql.conf
cp -fv /tmp/mssql.conf /var/opt/mssql/mssql.conf

openssl req -x509 -nodes -newkey rsa:4096 \
    -subj '/CN='${HOSTNAME} \
    -keyout "/ssl/${HOSTNAME}_mssql.key" \
    -out "/ssl/${HOSTNAME}_mssql.pem" -days 365

echo "[*] Pre customizing sql server done"

touch /var/opt/mssql/configure_done

exit 0
