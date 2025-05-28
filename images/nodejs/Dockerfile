FROM webera/base

ARG NODE_VERSION=20

# Install Node.js in a single layer
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl && \
    curl -fsSL https://raw.githubusercontent.com/tj/n/master/bin/n | bash -s $NODE_VERSION && \
    ln -sf /usr/local/bin/node /usr/bin/node && \
    ln -sf /usr/local/bin/npm /usr/bin/npm && \
    npm install -g npm@latest && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV NODE_ENV=production \
    PORT=3000

# Add health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=40s --retries=3 \
  CMD node -e "process.exit(0)" || exit 1

USER webera
WORKDIR /app
EXPOSE 3000
