#!/bin/sh

echo "Setting Laravel runtime config..."

set -e
cd /var/www/html


# Ensure Laravel has a key (only if missing)
if [ ! -f .env ]; then
  cp .env.example .env
fi

if ! grep -q "APP_KEY=base64" .env; then
  php artisan key:generate --force
fi

echo "APP_KEY=$APP_KEY" >> .env

RUN php artisan config:clear || true
RUN php artisan cache:clear || true
php artisan migrate --force

exec apache2-foreground
