FROM webera/base

# Install MySQL client and tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        mysql-client \
        mycli \
        curl \
        jq && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV MYSQL_HOST=localhost \
    MYSQL_PORT=3306 \
    MYSQL_DATABASE=mysql

# Add mysql config
RUN mkdir -p /home/webera/.mysql && \
    echo "[client]\nprompt='\\u@\\h [\\d]> '\nauto-rehash" > /home/webera/.my.cnf && \
    chown -R webera:webera /home/webera

USER webera
WORKDIR /workspace

# Set up useful aliases
RUN echo "alias mysql='mysql --auto-vertical-output'" >> /home/webera/.bashrc && \
    echo "alias mycli='mycli --auto-vertical-output'" >> /home/webera/.bashrc