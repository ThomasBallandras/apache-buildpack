#!/bin/bash
set -x
# Compiling erb file
/app/vendor/apache2/conf/httpd.conf.erb > /app/vendor/apache2/conf/httpd.conf

# Starting
/app/.apt/usr/sbin/apache2 -f /app/vendor/apache2/conf/httpd.conf