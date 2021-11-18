#!/usr/bin/env bash

sudo docker-compose down
sudo docker rmi mssql-2017
sudo docker volume rm sql-server-2017-linux-multi_shared
