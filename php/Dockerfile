FROM php:7.4-fpm-alpine3.12

RUN mkdir -p /etc/apk/cache && apk update && \
    apk add gmp-dev libxml2-dev libpng-dev freetype-dev libjpeg-turbo-dev libwebp-dev libzip libzip-dev && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install bcmath pdo_mysql mysqli gd gmp soap zip exif

RUN apk add --no-cache autoconf git g++ make openssl-dev && \
    git clone https://github.com/phpredis/phpredis.git && \
    cd phpredis && \
    git checkout a080b73f07815adf7668e0e70fa4184be606fd6b && \
    phpize && \
    ./configure && \
    make && make install && \
    pecl install mongodb && \
    docker-php-ext-enable redis mongodb

RUN rm -rf /var/cache/apk && rm -rf /etc/apk/cache

COPY ./laravel.ini /usr/local/etc/php/conf.d
COPY ./xlaravel.pool.conf /usr/local/etc/php-fpm.d/

WORKDIR /var/www

EXPOSE 9000
