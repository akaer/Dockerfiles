#!/usr/bin/env bash

# global variables
SCRIPT_ARGS="$@"
SCRIPT_NAME="$0"
SCRIPT_NAME="${SCRIPT_NAME#\./}"
SCRIPT_NAME="${SCRIPT_NAME##/*/}"
SCRIPT_BASE_DIR="$(cd "$( dirname "$0")" && pwd )"

run_sql_file() {
    local -r SQLFILE="${1:-unset}"; shift

    /opt/mssql-tools/bin/sqlcmd -S localhost -U "${DATABASE_USER}" -P "${SA_PASSWORD}" -i "${SQLFILE}"
}

echo "[*] Wait for server to startup"
while [ ! -f /var/opt/mssql/log/errorlog ]
do
    sleep 2
done

while true
do
    if grep -i -q "has been set for engine and full-text services" /var/opt/mssql/log/errorlog; then
        break
    else
        sleep 5
    fi
done

for sf in $(ls -v /tmp/*.sql);
do
    echo "[+] Execute ${sf}"
    run_sql_file "${sf}"
done

exit 0
