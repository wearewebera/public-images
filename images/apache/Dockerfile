FROM webera/base

# Set up the apache environment variables
ENV APACHE_HOME=/var/www/public_html \
    HEALTH_HOME=/var/health \
    SERVER_ROOT=/etc/apache2/ \
    APACHE_PORT=8080 \
    APACHE_RUN_USER=www-data \
    APACHE_RUN_GROUP=www-data \
    APACHE_LOG_DIR=/var/log/apache2 \
    APACHE_LOCK_DIR=/var/lock/apache2 \
    APACHE_RUN_DIR=/var/run/ \
    PHP_FPM_HOST=localhost \
    PHP_FPM_PORT=9000

COPY assets /tmp/assets
RUN /tmp/assets/build.sh && rm -rf /tmp/assets

# Add health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=40s --retries=3 \
  CMD curl -f http://localhost:${APACHE_PORT}/health || exit 1

USER www-data
EXPOSE 8080
ENTRYPOINT ["/bin/entrypoint.sh"]
