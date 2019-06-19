#!/usr/bin/env bash

sudo docker-compose down
sudo rm -rf data_db* trace_db* data_shared ssl
sudo docker rmi mssql-2019
