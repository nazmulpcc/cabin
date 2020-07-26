FROM php:7.2-fpm-alpine3.10

RUN mkdir -p /etc/apk/cache && apk update && \
    apk add gmp-dev && \
    apk add libxml2-dev && \
    apk add libpng-dev freetype-dev libjpeg-turbo-dev libwebp-dev && \
    docker-php-ext-configure gd \
    --with-gd \
    --with-webp-dir \
    --with-jpeg-dir \
    --with-png-dir \
    --with-zlib-dir \
    --with-freetype-dir && \
    docker-php-ext-install bcmath pdo_mysql mysqli gd gmp soap

RUN apk add --no-cache autoconf git g++ make && \
    git clone https://github.com/phpredis/phpredis.git && \
    cd phpredis && \
    git checkout a080b73f07815adf7668e0e70fa4184be606fd6b && \
    phpize && \
    ./configure && \
    make && make install && \
    docker-php-ext-enable redis

RUN rm -rf /var/cache/apk && rm -rf /etc/apk/cache

COPY ./laravel.ini /usr/local/etc/php/conf.d
COPY ./xlaravel.pool.conf /usr/local/etc/php-fpm.d/

EXPOSE 9000