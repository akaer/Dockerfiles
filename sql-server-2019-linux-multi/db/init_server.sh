#!/usr/bin/env bash

replace_vars() {
    local -r DSTFILE="${1}"; shift

    sed -i -e "s|@@HOSTNAME@@|${HOSTNAME}|" \
        "${DSTFILE}"
}

echo "[*] Pre customizing sql server"

cp -iv /tmp/mssql.conf /var/opt/mssql/mssql.conf
replace_vars /var/opt/mssql/mssql.conf

openssl req -x509 -nodes -newkey rsa:4096 \
    -subj '/CN='${HOSTNAME} \
    -keyout "/ssl/${HOSTNAME}_mssql.key" \
    -out "/ssl/${HOSTNAME}_mssql.pem" -days 365

echo "[*] Pre customizing sql server done"

exit 0
