FROM php:7.3.3-apache

#install all the system dependencies
RUN apt-get upgrade
RUN apt-get update && apt-get install -y \
  sqlite3 libsqlite3-dev \
  libicu-dev \
  git \
  libpq-dev \
  mysql-client \
  zip \
  unzip \
  vim \
  # https://github.com/Safran/RoPA/issues/4
  libzip-dev \
  # https://stackoverflow.com/questions/2977662/php-zip-installation-on-linux
  zlib1g-dev \
  && rm -r /var/lib/apt/lists/*
# configure the php modules
RUN docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd \
  && docker-php-ext-install \
  intl \
  mbstring \
  pcntl \
  pdo_mysql \
  zip \
  opcache
#install composer
# RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
# RUN php -r "if (hash_file('sha384', 'composer-setup.php') === '48e3236262b34d30969dca3c37281b3b4bbe3221bda826ac6a9a62d6444cdb0dcd0615698a5cbe587c3f0fe57a54d8f5') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
# RUN php composer-setup.php
# RUN php -r "unlink('composer-setup.php');"
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Execute the following command to move the composer.phar to a directory that is in your path
# RUN mv composer.phar /usr/local/bin/composer

# # Enable PHP extensions
RUN docker-php-ext-install pdo_mysql mysqli

# # Add cake and composer command to system path
ENV PATH="${PATH}:/var/www/html/lib/Cake/Console"
ENV PATH="${PATH}:/var/www/html/app/Vendor/bin"

#set our application folder as an environment variable
ENV APP_HOME /var/www/html
#change uid and gid of apache to docker user uid/gid
RUN usermod -u 1000 www-data && groupmod -g 1000 www-data
#change the web_root to cakephp /var/www/html/webroot folder
# RUN sed -i -e "s/html/html\/webroot/g" /etc/apache2/sites-enabled/000-default.conf

# COPY apache site.conf file
COPY ./docker/apache/site.conf /etc/apache2/sites-available/000-default.conf

# enable apache module rewrite
RUN a2enmod rewrite
#copy source files and run composer
COPY . $APP_HOME
# install all PHP dependencies
# RUN composer install --no-interaction --no-plugins --no-scripts
#change ownership of our applications
RUN chown -R www-data:www-data $APP_HOME

EXPOSE 8083
