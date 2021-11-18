#!/usr/bin/env bash

set -Eeuo pipefail

# global variables
SCRIPT_ARGS="$@"
SCRIPT_NAME="$0"
SCRIPT_NAME="${SCRIPT_NAME#\./}"
SCRIPT_NAME="${SCRIPT_NAME##/*/}"
SCRIPT_BASE_DIR="$(cd "$( dirname "$0")" && pwd )"

[[ -e "${SCRIPT_BASE_DIR}/common.inc" ]] && source "${SCRIPT_BASE_DIR}/common.inc"

declare -r MAXDELAY=30

Q=$(cat <<-'_EOF_'
set nocount on
select 1
_EOF_
)

while [[ $(run_sql_query_batch "${Q}" "tempdb") -ne 1 ]]
do
    echo "[*] Waiting for SQL Server to accept connections"
    sleep ${MAXDELAY}
done

for sf in $(ls -v /tmp/*.sql);
do
    echo "Execute ${sf}"
    replace_vars "${sf}"
    run_sql_file "${sf}"
done

exit 0
