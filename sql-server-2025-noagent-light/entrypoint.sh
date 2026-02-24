#!/usr/bin/env bash

(nohup /tmp/configure_sqlserver.sh &) \
    && /opt/mssql/bin/sqlservr mssql
