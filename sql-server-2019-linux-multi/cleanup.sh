#!/usr/bin/env bash

sudo docker-compose down
sudo rm -rf data/db1 data/db2 data/db3 data/shared
sudo docker rmi mssql-2019
