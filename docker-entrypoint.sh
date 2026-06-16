#!/bin/sh

echo "Setting Laravel runtime config..."


cp .env.example .env

echo "APP_KEY=$APP_KEY" >> .env

php artisan config:clear
php artisan migrate --force

exec apache2-foreground
