#!/bin/bash

# Setting Mellon key, cert and metadata files
if grep -q "libapache2-mod-auth-mellon" "${HOME}/.apache-mods" ; then
  
  export APACHE_DIR="${APACHE_DIR:-$HOME/vendor/apache2}"
  export MELLON_DIR="${MELLON_DIR:-$APACHE_DIR/mellon}"
  mkdir -p "${MELLON_DIR}"

  if [[ -z "${MELLON_SP_METADATA}" ]]; then
    echo "WARNING: MELLON_SP_METADATA is not set. Mellon may not work!"
  else
    echo "Exporting xml matadata file..."
    echo "${MELLON_SP_METADATA}" | base64 --decode >> "${MELLON_DIR}/mellon.xml"
    chmod 644 "${MELLON_DIR}/mellon.xml"
  fi

  if [[ -z "${MELLON_SP_CERT}" ]]; then
    echo "WARNING: MELLON_SP_CERT is not set. Mellon may not work!"
  else
    echo "Exporting certificate file..."
    echo "${MELLON_SP_CERT}" | base64 --decode >> "${MELLON_DIR}/mellon.cert"
    chmod 644 "${MELLON_DIR}/mellon.cert"
  fi

  if [[ -z "${MELLON_SP_KEY}" ]]; then
    echo "WARNING: MELLON_SP_KEY is not set. Mellon may not work!"
  else
    echo "Exporting key file..."
    echo "${MELLON_SP_KEY}" | base64 --decode >> "${MELLON_DIR}/mellon.key"
    chmod 600 "${MELLON_DIR}/mellon.key"
  fi

  if [[ -z "${MELLON_IDP_METADATA}" ]]; then
    echo "WARNING: MELLON_IDP_METADATA is not set. Mellon may not work!"
  else
    echo "Exporting IdP xml metadata file..."
    echo "${MELLON_IDP_METADATA}" | base64 --decode >> "${MELLON_DIR}/mellon_idp_metadata.xml"
    chmod 644 "${MELLON_DIR}/mellon_idp_metadata.xml"
  fi
fi

# Compiling conf file
echo "compiling conf file..."
erb "${HOME}/vendor/apache2/conf/httpd.conf.erb" > "${HOME}/vendor/apache2/conf/httpd.conf"

if [ -f "${HOME}/apache.conf.erb" ] ; then
  erb "${HOME}/apache.conf.erb" > "${HOME}/vendor/apache2/conf/site.conf"
  
  # Testing if /app or /app/vendor are set in the DocumentRoot (insecure)
  if [[ -n $(grep -i 'DocumentRoot' "${HOME}/vendor/apache2/conf/site.conf" | grep -E '( '"${HOME}"'| '"${HOME}"'/vendor)') ]]; then
	  echo "ERROR: DocumentRoot should never be set to /app! Exiting..."
    exit 1
  fi

  echo "Include ${HOME}/vendor/apache2/conf/site.conf" >> "${HOME}/vendor/apache2/conf/httpd.conf"
fi

# Starting
echo "Starting Apache..."
"${HOME}"/.apt/usr/sbin/apache2 -f "${HOME}"/vendor/apache2/conf/httpd.conf -DFOREGROUND
