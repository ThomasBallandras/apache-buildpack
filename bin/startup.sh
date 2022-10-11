#!/bin/bash
set -x

# Compiling erb file
echo "compiling conf file..."
ls -la /app/vendor/apache2/conf/
/app/vendor/apache2/conf/httpd.conf.erb > /app/vendor/apache2/conf/httpd.conf

# Starting
echo "Starting Apache..."
/app/.apt/usr/sbin/apache2 -f /app/vendor/apache2/conf/httpd.conf