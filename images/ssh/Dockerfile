FROM webera/base

ENV USER_HOME /var/www
ENV SSH_RUN /run/sshd
ENV USER_CONNECTION user_cloud

COPY assets /tmp/assets
RUN /tmp/assets/build.sh && rm -rf /tmp/assets

WORKDIR $USER_HOME
USER $USER_CONNECTION
EXPOSE 10022
ENTRYPOINT [ "/bin/sshd", "-f", "/etc/ssh/sshd_config", "-p", "10022" ,"-D"]
