![alt text](swclogo.jpg)
## swc_zabbix7

* This repository contains a script to deploy Zabbix 7.0 LTS via docker containers. For any additional details or inquiries, please contact me at christopher.sargent@sargentwalker.io.
* Tested on Ubuntu 22.04 VM
* [Zabbix 7 LTS](https://www.zabbix.com/whats_new_7_0)
* [Zabbix Documentation](https://github.com/zabbix/zabbix-docker/blob/7.0/README.md)

### Docker install for Ubuntu 
1. ssh user@IP
2. sudo -i 
3. curl -fsSL https://get.docker.com -o install-docker.sh && sudo sh install-docker.sh

### Deploy Zabbix 7.0 LTS
1. ssh user@IP
2. sudo -i 
3. git clone 
4. cd swc_zabbix7
5. vim .env
* Update password
```
# Set your PostgreSQL credentials
POSTGRES_USER=zabbix
POSTGRES_PASSWORD=password
POSTGRES_DB=zabbix
```
6. ./zabbix7_deploy.sh
* Verify .sh scripts are executable chmod +x *.sh
7. docker ps 
```
CONTAINER ID   IMAGE                                             COMMAND                  CREATED         STATUS         PORTS                                                                                NAMES
c62f0268c750   zabbix/zabbix-web-nginx-pgsql:alpine-7.0-latest   "docker-entrypoint.sh"   2 minutes ago   Up 2 minutes   0.0.0.0:80->8080/tcp, [::]:80->8080/tcp, 0.0.0.0:443->8443/tcp, [::]:443->8443/tcp   zabbix-web-nginx-pgsql
c3cae38b3a92   zabbix/zabbix-server-pgsql:alpine-7.0-latest      "/usr/bin/docker-ent…"   2 minutes ago   Up 2 minutes   0.0.0.0:10051->10051/tcp, :::10051->10051/tcp                                        zabbix-server-pgsql
ab940544cbeb   zabbix/zabbix-snmptraps:alpine-7.0-latest         "/usr/sbin/snmptrapd…"   2 minutes ago   Up 2 minutes   0.0.0.0:162->1162/udp, [::]:162->1162/udp                                            zabbix-snmptraps
1ff5003c2d72   postgres:16.3                                     "docker-entrypoint.s…"   2 minutes ago   Up 2 minutes   5432/tcp                                                                             postgres-server
```
8. http://172.18.0.17

![Screenshot](resources/zabbixhttps.JPG)

### Create certs and dhparam for SSL/TLS
1. openssl req -newkey rsa:2048 -nodes -keyout /etc/ssl/nginx/ssl.key -x509 -days 365 -out /etc/ssl/nginx/ssl.crt
2. openssl dhparam -out /etc/ssl/nginx/dhparam.pem 2048
3. chmod 444 /etc/ssl/nginx/ssl.key
4. docker restart zabbix-web-nginx-pgsql
5. docker logs zabbix-web-nginx-pgsql -f
* Look for the following
```
** Adding Zabbix virtual host (HTTP)
** Enable SSL support for Nginx
** Preparing Zabbix frontend configuration file
########################################################
```
6. https://172.18.0.17
* Admin zabbix

![Screenshot](resources/zabbixhttps.JPG)

![Screenshot](resources/zabbix7dash.JPG)

