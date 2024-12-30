FROM webera/base

# Set up the apache environment variables
ENV APACHE_HOME /var/www/public_html
ENV HEALTH_HOME /var/health
ENV SERVER_ROOT /etc/apache2/
ENV APACHE_PORT 8080
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_RUN_DIR /var/run/

COPY assets /tmp/assets
RUN /tmp/assets/build.sh && rm -rf /tmp/assets

USER www-data
EXPOSE 8080
ENTRYPOINT ["/bin/entrypoint.sh"]
