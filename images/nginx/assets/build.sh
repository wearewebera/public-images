#!/bin/bash

#
# Install packages
#
apt-get update
apt-get install -y --no-install-recommends nginx
rm -rf /var/lib/apt/lists/*

#
# Set up directories and permissions
#
mkdir -p $NGINX_RUN_DIR $NGINX_LOCK_DIR $NGINX_LOG_DIR $NGINX_HOME
chown -R $NGINX_RUN_USER:$NGINX_RUN_GROUP $NGINX_HOME $NGINX_LOG_DIR $NGINX_RUN_DIR $NGINX_LIB_DIR

#
# Set up nginx customization
#
cp /tmp/assets/nginx.conf "${SERVER_ROOT}/"
cp /tmp/assets/default_site.conf "${SERVER_ROOT}/sites-available/default"
cp /tmp/assets/index.html "${NGINX_HOME}/"
chown $NGINX_RUN_USER:$NGINX_RUN_GROUP "${NGINX_HOME}/index.html"
