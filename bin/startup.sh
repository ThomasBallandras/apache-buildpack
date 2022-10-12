#!/bin/bash

# Compiling erb file
echo "compiling conf file..."
erb $HOME/vendor/apache2/conf/httpd.conf.erb > $HOME/vendor/apache2/conf/httpd.conf

#Pause for 2 sec to allow for erb command to complete
sleep 2

# Starting
echo "Starting Apache..."
$HOME/.apt/usr/sbin/apache2 -f $HOME/vendor/apache2/conf/httpd.conf