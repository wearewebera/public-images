FROM webera/base

ENV HOME=/var/www/public_html \
    PHP_MEMORY_LIMIT=128M \
    PHP_MAX_EXECUTION_TIME=30 \
    PHP_UPLOAD_MAX_FILESIZE=2M \
    PHP_POST_MAX_SIZE=8M

COPY assets /tmp/assets
RUN /tmp/assets/build.sh && rm -rf /tmp/assets

# Add health check using php-fpm status
HEALTHCHECK --interval=30s --timeout=3s --start-period=40s --retries=3 \
  CMD SCRIPT_NAME=/status SCRIPT_FILENAME=/status REQUEST_METHOD=GET cgi-fcgi -bind -connect 127.0.0.1:9000 || exit 1

USER www-data 
WORKDIR ${HOME}
EXPOSE 9000
ENTRYPOINT ["/usr/sbin/php-fpm" , "--fpm-config", "/etc/php/php-fpm.conf", "--nodaemonize"]
