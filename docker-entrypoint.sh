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
touch database/database.sqlite

chown -R www-data:www-data database storage bootstrap/cache
chmod -R 775 database storage bootstrap/cache
echo "Running migrations..."
php artisan migrate --force


echo "Caching config..."
php artisan config:cache

exec apache2-foreground
