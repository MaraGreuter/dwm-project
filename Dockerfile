FROM php:8.2-apache

RUN apt-get update && apt-get install -y \
    git unzip zip curl libzip-dev \
    && docker-php-ext-install pdo pdo_mysql zip \

RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs

RUN a2enmod rewrite

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html


COPY package*.json ./
RUN npm install

COPY . .

RUN composer install --no-dev --optimize-autoloader

RUN npm run build

RUN chown -R www-data:www-data storage bootstrap/cache \
    && chmod -R 775 storage bootstrap/cache

ENV APACHE_DOCUMENT_ROOT=/var/www/html/public

RUN sed -ri -e "s!/var/www/html!${APACHE_DOCUMENT_ROOT}!g" \
    /etc/apache2/sites-available/*.conf

RUN printf '<Directory /var/www/html/public>\n\
    AllowOverride All\n\
    Require all granted\n\
</Directory>\n' > /etc/apache2/conf-available/laravel.conf \
    && a2enconf laravel

EXPOSE  80
