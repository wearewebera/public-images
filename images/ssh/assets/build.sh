#!/bin/bash

#
# Install packages
#
apt-get update
apt-get install -y --no-install-recommends \
        openssh-server vim git wget curl mysql-client \
        ca-certificates php-cli php-mysql less
apt-get clean
rm -rf /var/lib/apt/lists/*

#
# Install external tools
#
curl -s -o /usr/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod 755 /usr/bin/wp

#
# Set up directories and permissions
#
mkdir -p ${SSH_RUN}
usermod -l ${USER_CONNECTION} -s /bin/bash www-data
mkdir -p ${USER_HOME}/.ssh
chown -R 33:33 ${USER_HOME}
find ${USER_HOME} -type d -exec chmod 755 {} \;
find ${USER_HOME} -type f -exec chmod 644 {} \;

#
# Set up OpenSSH customization
#
cp /tmp/assets/sshd_config /etc/ssh/
cp /tmp/assets/prompt_conf.sh /etc/profile.d/
sed -i /UsePAM/d /etc/ssh/sshd_config
chown -R 33:33 /etc/ssh/

#
# Commands customization
#
mv /usr/sbin/sshd /bin/
rm /usr/bin/mount /usr/bin/df /usr/bin/findmnt /usr/bin/lsblk \
   /usr/bin/uptime /usr/bin/w /usr/bin/users /usr/bin/who /usr/bin/whoami  \
   /usr/bin/free /usr/bin/top /usr/bin/last /usr/bin/ps /usr/bin/kill \
   /usr/bin/mountpoint /usr/bin/su /usr/bin/id /usr/bin/apt* \
   /usr/bin/add* /sbin/*
