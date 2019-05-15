# Base image for usage in with Symfony and ImageMagick installations

This image uses the official PHP alpine fpm image as base and adds ImageMagick and other PHP extensions on top.
Its usage is mainly intendet for a specific project we are working on.

To use this as a base image for an application's Dockerfile it could look like this:

```
FROM subugoe/digizeit-base

ENV COMPOSER_ALLOW_SUPERUSER 1
# More environment variables when needed

WORKDIR /var/www/html/
COPY . /var/www/html/

RUN php composer.phar install --prefer-dist --no-progress --no-suggest --optimize-autoloader --classmap-authoritative  --no-interaction && \
    php composer.phar clear-cache && \
    # Compile frontend assets
    yarn install && \
    yarn run encore production && \
    # Clean up
    rm -rf node_modules  && \
    apk del --purge \
        yarn \
        nodejs-current \
        git && \
    rm -rf /var/cache/apk/* && \
    chmod -R 777 /var/www/html/var
```