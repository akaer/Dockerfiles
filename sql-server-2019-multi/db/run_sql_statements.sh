#!/usr/bin/env bash

set -Eeuo pipefail

# global variables
SCRIPT_ARGS="$@"
SCRIPT_NAME="$0"
SCRIPT_NAME="${SCRIPT_NAME#\./}"
SCRIPT_NAME="${SCRIPT_NAME##/*/}"
SCRIPT_BASE_DIR="$(cd "$( dirname "$0")" && pwd )"

[[ -e "${SCRIPT_BASE_DIR}/common.inc" ]] && source "${SCRIPT_BASE_DIR}/common.inc"

echo "Wait for server to startup"
while [ ! -f /var/opt/mssql/log/errorlog ]
do
    sleep 2
done

while true
do
    if grep -i -q "Using 'xpstar.dll' version" /var/opt/mssql/log/errorlog; then
        break
    else
        sleep 5
    fi
done

for sf in $(ls -v /tmp/*.sql);
do
    echo "Execute ${sf}"
    replace_vars "${sf}"
    run_sql_file "${sf}"
done

exit 0
