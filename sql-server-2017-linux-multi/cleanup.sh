#!/usr/bin/env bash

sudo docker-compose down
sudo rm -rf data/db1 data/db2 data/shared
sudo docker rmi mssql-2017
