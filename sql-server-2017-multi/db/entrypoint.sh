#!/usr/bin/env bash

/tmp/init_server.sh \
    && (nohup /tmp/run_sql_statements.sh >/tmp/run_sql_statements.log 2>&1 &) \
    && /opt/mssql/bin/sqlservr
