FROM php:8.2-apache

RUN apt-get update && apt-get install -y \
    git unzip zip curl libzip-dev \
    && docker-php-ext-install pdo pdo_mysql zip

RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs

RUN a2enmod rewrite

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

COPY composer.json composer.lock ./
RUN composer install \
    --no-dev \
    --optimize-autoloader \
    --no-interaction \
    --no-scripts \
    --prefer-dist

COPY package.json package-lock.json ./
RUN npm ci
COPY . .
RUN npm run build

RUN php artisan optimize:clear || true

#COPY .env.example .env

#RUN php artisan key:generate

RUN mkdir -p storage/logs bootsrap/cache \
    && chown -R www-data:www-data storage bootstrap/cache \
    && chmod -R 775 storage bootstrap/cache

ENV APACHE_DOCUMENT_ROOT=/var/www/html/public

RUN sed -i 's#/var/www/html#/var/www/html/public#g' \
    /etc/apache2/sites-available/000-default.conf

RUN printf '<Directory /var/www/html/public>\n\
    AllowOverride All\n\
    Require all granted\n\
</Directory>\n' > /etc/apache2/conf-available/laravel.conf \
    && a2enconf laravel

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE  80

CMD ["docker-entrypoint.sh"]
