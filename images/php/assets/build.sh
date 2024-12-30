#!/bin/bash

#
# Install packages
#
apt-get update
apt-get install -y --no-install-recommends \
        ca-certificates less vim curl git wget libfcgi-bin \
        php-fpm php-common php-mysql php-xmlrpc php-curl php-gd \
        php-imagick php-dev php-imap php-mbstring php-soap php-zip \
        php-bcmath php-xml php-intl php-cli
apt-get clean
rm -rf /var/lib/apt/lists/*

#
# Set up directories and permissions
#
mkdir -p /run/php /var/cache/php ${HOME}
cp /tmp/assets/index.php ${HOME}
touch /var/log/php-fpm.log
chown www-data:www-data /run/php /var/cache/php ${HOME} ${HOME}/index.php /var/log/php-fpm.log

#
# Find php configurations
#
php_fpm_conf=$(find /etc/php -name php-fpm.conf)
php_fpm_www=$(find /etc/php -name www.conf)

#
# Set up links to Entrypoint
#
ln -s ${php_fpm_conf} /etc/php/php-fpm.conf
ln -s /usr/sbin/php-fpm* /usr/sbin/php-fpm

#
# Set up PHP customization
#
sed -i 's@^error_log.*@error_log = /proc/self/fd/2@' ${php_fpm_conf}
sed -i 's@^listen.*@listen = 9000@' ${php_fpm_www}
sed -i 's/^;pm.status_path/pm.status_path/' ${php_fpm_www}
sed -i 's@^;access\.log.*@access.log = /proc/self/fd/1@' ${php_fpm_www}
sed -i 's@^;clear_env = no@clear_env = no@' ${php_fpm_www}
echo catch_workers_output = yes >> ${php_fpm_www}
echo php_flag[display_errors] = on >> ${php_fpm_www}
echo php_admin_flag[log_errors] = on >> ${php_fpm_www}
echo php_admin_value[error_log] = /proc/self/fd/2 >> ${php_fpm_www}

#
# Install php-fpm-healthcheck
#
wget -O /usr/local/bin/php-fpm-healthcheck \
    https://raw.githubusercontent.com/renatomefi/php-fpm-healthcheck/master/php-fpm-healthcheck
test -f ${HOME}/.wget-hsts && rm -f ${HOME}/.wget-hsts
chmod +x /usr/local/bin/php-fpm-healthcheck
