#!/usr/bin/env bash

/tmp/init_server.sh \
    && (nohup /tmp/run_sql_statements.sh &) \
    && /opt/mssql/bin/sqlservr
