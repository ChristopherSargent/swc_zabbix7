#!/bin/bash

# Define an array containing the names of Docker containers to restart
containers=(
    "zabbix-web-nginx-pgsql"
    "zabbix-server-pgsql"
    "zabbix-snmptraps"
    "postgres-server"
)

# Iterate over the array and restart each Docker container
for container in "${containers[@]}"; do
    docker rm -f "$container"
done

