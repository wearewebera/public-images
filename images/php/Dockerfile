FROM webera/base
ENV HOME=/var/www/public_html

COPY assets /tmp/assets
RUN /tmp/assets/build.sh && rm -rf /tmp/assets

USER www-data 
WORKDIR ${HOME}
EXPOSE 9000
ENTRYPOINT ["/usr/sbin/php-fpm" , "--fpm-config", "/etc/php/php-fpm.conf", "--nodaemonize"]
