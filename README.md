# Intro

This cakePHP V3.9.10  dockerized application is just an example, feel free to replace the content inside the app folder with your own cakephp aplicatinon code.

## IMAGES ##
```
PHP Version 7.3.3 - php:7.3.3-apache
MYSQL V5.6 - mysql:5.6
```

## Enviorment variables .env  ##
#### Rename env.sample to .env and add your own configuration, db name, ports etc... ####
```
MYSQL_ROOT_PASSWORD=root
MYSQL_DATABASE=cms
MYSQL_USER=user
MYSQL_PASSWORD=password
MYSQL_PORT=33006
APP_PORT=8083
```

## Database ##
The example database cms is just an example, feel free to update this sql code with your own database skeleton.

## Sql ##
```bash
/db/db.sql
```

## init_db.sh ##
```
#!/bin/bash
/usr/bin/mysqld_safe --skip-grant-tables &
sleep 5
mysql -u root -e "CREATE DATABASE IF NOT EXISTS <db_name>"
mysql -u root cms < /tmp/db.sql
```

## Build && run the container

```bash
docker-compose build --no-cache
```

```
docker-compose up
````
# Install dependencies #
TODO: add script to Dockerfile to do this task.

## Generate the vendor folder / run composer ##
```
docker exec -it cake3-webserver bash
```
### Inside the app container ###
```
cd app
composer update
```
