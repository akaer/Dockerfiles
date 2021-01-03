#!/bin/bash

set -Eeuo pipefail

# global variables
SCRIPT_ARGS="$@"
SCRIPT_NAME="$0"
SCRIPT_NAME="${SCRIPT_NAME#\./}"
SCRIPT_NAME="${SCRIPT_NAME##/*/}"
SCRIPT_BASE_DIR="$(cd "$( dirname "$0")" && pwd )"

echo "[*] Wait for LDAP server"
sleep 90

opendj/bin/dsconfig -n -X -w "${ROOT_PASSWORD}" --hostname localhost --port 4444 --bindDN "cn=Directory Manager" set-connection-handler-prop --handler-name "LDAPS Connection Handler" --add ssl-protocol:TLSv1.2
opendj/bin/dsconfig -n -X -w "${ROOT_PASSWORD}" --hostname localhost --port 4444 --bindDN "cn=Directory Manager" set-administration-connector-prop --add ssl-protocol:TLSv1.2
opendj/bin/dsconfig -n -X -w "${ROOT_PASSWORD}" --hostname localhost --port 4444 --bindDN "cn=Directory Manager" set-crypto-manager-prop --add ssl-protocol:TLSv1.2
opendj/bin/dsconfig -n -X -w "${ROOT_PASSWORD}" --hostname localhost --port 4444 --bindDN "cn=Directory Manager" set-plugin-prop --plugin-name "Referential Integrity" --set enabled:true
