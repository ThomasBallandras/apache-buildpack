#!/bin/bash
set -x

# Compiling erb file
echo "compiling conf file..."
erb /app/vendor/apache2/conf/httpd.conf.erb > /app/vendor/apache2/conf/httpd.conf

cat /app/vendor/apache2/conf/httpd.conf

# Starting
echo "Starting Apache..."
/app/.apt/usr/sbin/apache2 -f /app/vendor/apache2/conf/httpd.conf

cat /app/vendor/apache2/logs/error_log

ps -aux