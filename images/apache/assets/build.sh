#!/bin/bash

#
# Install packages
#
apt-get update
apt-get install -y --no-install-recommends apache2
apt-get clean
rm -rf /var/lib/apt/lists/*

#
# Set up directories and permissions
#
mkdir -p $APACHE_RUN_DIR $APACHE_LOCK_DIR $APACHE_LOG_DIR $APACHE_HOME $HEALTH_HOME
chown -R $APACHE_RUN_USER:$APACHE_RUN_GROUP $APACHE_RUN_DIR $APACHE_LOCK_DIR $APACHE_HOME $APACHE_LOG_DIR $HEALTH_HOME

#
# Set up Apache customization
#
a2enmod rewrite proxy_fcgi
sed -i '/Listen/d' /etc/apache2/ports.conf
cp /tmp/assets/apache2.conf "${SERVER_ROOT}/"
cp /tmp/assets/health.html "${HEALTH_HOME}/index.html"
cp /tmp/assets/000-default.conf "${SERVER_ROOT}/sites-enabled/"
cp /tmp/assets/health.conf "${SERVER_ROOT}/sites-enabled/"
chown $APACHE_RUN_USER:$APACHE_RUN_GROUP "$HEALTH_HOME/index.html"
cp /tmp/assets/entrypoint.sh /bin/
