FROM webera/base

ENV NGINX_HOME /var/www/public_html
ENV SERVER_ROOT /etc/nginx
ENV NGINX_PORT 8080
ENV NGINX_RUN_USER www-data
ENV NGINX_RUN_GROUP www-data
ENV NGINX_LOG_DIR /var/log/nginx
ENV NGINX_RUN_DIR /run 
ENV NGINX_LIB_DIR /var/lib/nginx

COPY assets /tmp/assets
RUN /tmp/assets/build.sh && rm -rf /tmp/assets

USER www-data

EXPOSE 8080

ENTRYPOINT [ "/usr/sbin/nginx", "-g", "daemon off;"]
