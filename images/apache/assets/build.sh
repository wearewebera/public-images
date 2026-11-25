#!/bin/bash

#
# Install packages
#
apt-get update
apt-get dist-upgrade -y
apt-get install -y --no-install-recommends apache2

# Ship current Ubuntu security fixes, and fail the build rather than publish an
# image older than the last known-good patch level (wearewebera/washington#1251:
# the running image was 11 apache2 and 10 OpenSSL security updates behind).
for floor in apache2=2.4.58-1ubuntu8.19 libssl3t64=3.0.13-0ubuntu3.16; do
    pkg=${floor%%=*}; min=${floor#*=}
    have=$(dpkg-query -W -f='${Version}' "$pkg")
    if ! dpkg --compare-versions "$have" ge "$min"; then
        echo "ERROR: $pkg $have is older than $min" >&2
        exit 1
    fi
done
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
