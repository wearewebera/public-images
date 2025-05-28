FROM webera/base

ENV NGINX_HOME=/var/www/public_html \
    SERVER_ROOT=/etc/nginx \
    NGINX_PORT=8080 \
    NGINX_RUN_USER=www-data \
    NGINX_RUN_GROUP=www-data \
    NGINX_LOG_DIR=/var/log/nginx \
    NGINX_RUN_DIR=/run \
    NGINX_LIB_DIR=/var/lib/nginx \
    PHP_FPM_HOST=localhost \
    PHP_FPM_PORT=9000

COPY assets /tmp/assets
RUN /tmp/assets/build.sh && rm -rf /tmp/assets

# Add health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=40s --retries=3 \
  CMD curl -f http://localhost:${NGINX_PORT}/ || exit 1

USER www-data

EXPOSE 8080

ENTRYPOINT [ "/usr/sbin/nginx", "-g", "daemon off;"]
