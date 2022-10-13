#!/bin/bash

# Compiling conf file
echo "compiling conf file..."
erb "${HOME}/vendor/apache2/conf/httpd.conf.erb" > "${HOME}/vendor/apache2/conf/httpd.conf"

if [ -f "${HOME}/apache.conf.erb" ] ; then
  erb "${HOME}/apache.conf.erb" > "${HOME}/vendor/apache2/conf/site.conf"
  echo "Include ${HOME}/vendor/apache2/conf/site.conf" >> "${HOME}/vendor/apache2/conf/httpd.conf"
fi

# Adding SSL directory in case SSL is required
if [ -d "${HOME}/ssl" ] ; then
  cp -r "${HOME}/ssl" "${HOME}/vendor/apache2/"
fi

# Starting
echo "Starting Apache..."
$HOME/.apt/usr/sbin/apache2 -f $HOME/vendor/apache2/conf/httpd.conf -DFOREGROUND
