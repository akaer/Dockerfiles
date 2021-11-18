#!/usr/bin/env bash

sudo docker-compose down
sudo docker rmi mssql-2019
sudo docker volume rm sql-server-2019-linux-multi_shared sql-server-2019-linux-multi_ssl
