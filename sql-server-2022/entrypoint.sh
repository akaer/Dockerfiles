#!/usr/bin/env bash

/tmp/init_server.sh \
    && (nohup /tmp/configure_sqlserver.sh &) \
    && su mssql -c '/opt/mssql/bin/sqlservr'
