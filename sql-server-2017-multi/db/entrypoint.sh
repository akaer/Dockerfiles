#!/usr/bin/env bash

/init_server.sh \
    && (nohup /run_sql_statements.sh &) \
    && /opt/mssql/bin/sqlservr
