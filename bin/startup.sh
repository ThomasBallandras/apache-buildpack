#!/bin/bash
set -x

# Compiling erb file
echo "compiling conf file..."
erb $HOME/vendor/apache2/conf/httpd.conf.erb > $HOME/vendor/apache2/conf/httpd.conf

# Starting
echo "Starting Apache..."
$HOME/.apt/usr/sbin/apache2 -f $HOME/vendor/apache2/conf/httpd.conf

cat $HOME/vendor/apache2/logs/error_log
