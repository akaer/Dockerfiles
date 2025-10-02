#!/usr/bin/env bash

(nohup /tmp/configure_sqlserver.sh &) \
    && su -c /opt/mssql/bin/sqlservr mssql
