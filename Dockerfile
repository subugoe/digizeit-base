FROM php:7.3-fpm-alpine3.9

MAINTAINER Ingo Pfennigstorf <pfennigstorf@sub.uni-goettingen.de>

ENV COMPOSER_ALLOW_SUPERUSER 1
WORKDIR /var/www/html/

RUN apk add --update --no-cache \
        icu-dev \
        git \
        wget \
        nodejs-current \
        libpng-dev \
        gd \
        yarn \
        autoconf \
        make \
        gcc \
        g++ \
        libtool \
        libjpeg-turbo-dev \
        imagemagick-dev \
        openldap-dev \
        bzip2-dev \
        python \
        libzip-dev \
        imagemagick && \
    # Install PHP extensions
    docker-php-ext-install \
        intl \
        gd \
        zip \
        bz2 \
        ldap \
        mysqli \
        pdo \
        pdo_mysql \
        opcache && \
    pecl install \
        imagick \
        apcu && \
    docker-php-ext-enable \
        gd \
        imagick \
        ldap \
        apcu && \
    printf "memory_limit=1536M" > /usr/local/etc/php/conf.d/memory-limit.ini && \
    printf '[PHP]\ndate.timezone = "Europe/Berlin"\n' > /usr/local/etc/php/conf.d/tzone.ini && \
    docker-php-source delete && \
    curl -sS https://getcomposer.org/installer | php && \
    apk del --purge \
        autoconf \
        g++ \
        make \
        libtool \
        gcc \
        python
