replace_vars() {
    local -r DSTFILE="${1:-unset}"; shift

    local IPADDR=$(/sbin/ifconfig eth0 |awk '/inet addr/ { gsub(".*:", "", $2) ; print $2 }')
    local NETMASK=$(/sbin/ifconfig eth0 |awk '/Mask/ { gsub(".*:", "", $4) ; print $4 }')

    if [[ -z "${IPADDR}" ]]; then
        IPADDR=$(/sbin/ifconfig eth0 |awk '/inet/ { gsub(".*:", "", $2) ; print $2 }')
    fi

    if [[ -z "${NETMASK}" ]]; then
        NETMASK=$(/sbin/ifconfig eth0 |awk '/netmask/ { gsub(".*:", "", $4) ; print $4 }')
    fi

    sed -i -e "s|@@HOSTNAME@@|${HOSTNAME}|g" \
           -e "s|@@PASSWORD@@|${SA_PASSWORD}|g" \
           -e "s|@@IP@@|${IPADDR}|g" \
           -e "s|@@DATABASE_MEMORYLIMITMB@@|${DATABASE_MEMORYLIMITMB}|g" \
           -e "s|@@NETMASK@@|${NETMASK}|g" \
        "${DSTFILE}"
}

run_sql_query_batch() {
    local -r QUERY="${1:-unset}"; shift
    local -r DBNAME="${1:-unset}"; shift

    /opt/mssql-tools/bin/sqlcmd -S localhost -U "${DATABASE_USER}" -P "${SA_PASSWORD}" -d "${DBNAME}" -b -W -u -h -1 -Q "${QUERY}"
}

run_sql_file() {
    local -r SQLFILE="${1:-unset}"; shift

    /opt/mssql-tools/bin/sqlcmd -S localhost -U "${DATABASE_USER}" -P "${SA_PASSWORD}" -i "${SQLFILE}"
}
