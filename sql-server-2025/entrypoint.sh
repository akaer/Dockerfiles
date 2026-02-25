#!/usr/bin/env bash

/tmp/init_server.sh \
	&& (nohup /tmp/configure_sqlserver.sh &) \
	&& /opt/mssql/bin/sqlservr
