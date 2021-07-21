# Intro

This cakePHP **V3.9.10**  dockerized application is just an example based on the  cakePHP official documentation [ CMS tutorial](https://book.cakephp.org/3/en/tutorials-and-examples/cms/tags-and-users.html), feel free to replace the content inside the app folder with your own cakephp aplicatinon code.


## IMAGES ##
```
PHP Version 7.3.3 - php:7.3.3-apache
MYSQL V5.6 - mysql:5.6
```

## Environment variables .env  ##
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
### Inside the **cake3-webserver** container ###
```
cd app
composer update
```

## posible issues ##
1. Cache directory not writable
2. Logs directory not writable
Add the right permissions to this folders in your host (not need to do inside the container)

Example ( **give permissions with careful, this is just an example for development, not for production** )
```
sudo chmod 777 /app/tmp -R
sudo chmod 777 /app/logs -R

```

