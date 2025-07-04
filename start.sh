#!/bin/bash
echo "♻️ Clearing temporary files and cache..."
rm -rf /home/container/tmp/*
rm -rf /home/container/apache/socks/*

PHP_VERSION="${PHP_VERSION:-8.4}"

echo "⟳ Starting PHP-FPM (version $PHP_VERSION)..."
php-fpm$PHP_VERSION -c /home/container/php/php.ini --fpm-config /home/container/php/php-fpm.conf &
if [ $? -ne 0 ]; then
    echo "❌ Failed to start PHP-FPM"
    exit 1
fi

echo "⟳ Starting Nginx..."
nginx -c "/home/container/nginx/nginx.conf" -p "/home/container" &
if [ $? -ne 0 ]; then
    echo "❌ Failed to start Nginx"
    exit 1
fi

echo "✓ Services successfully launched"