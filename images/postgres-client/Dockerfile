FROM webera/base

# Install PostgreSQL client and tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        postgresql-client \
        postgresql-contrib \
        pgcli \
        curl \
        jq && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV PGHOST=localhost \
    PGPORT=5432 \
    PGUSER=postgres \
    PGDATABASE=postgres

# Add psql config
RUN mkdir -p /home/webera/.psql_history && \
    chown -R webera:webera /home/webera

USER webera
WORKDIR /workspace

# Set up useful aliases
RUN echo "alias psql='psql -x'" >> /home/webera/.bashrc && \
    echo "alias pgcli='pgcli --auto-vertical-output'" >> /home/webera/.bashrc