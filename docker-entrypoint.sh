#!/bin/sh

echo "Setting Laravel runtime config..."

if [ -z "$APP_KEY" ]; then
  echo "APP_KEY missing!"
  exit 1
fi

cp .env.example .env

echo "APP_KEY=$APP_KEY" >> .env

php artisan config:clear
php artisan migrate --force

exec apache2-foreground
