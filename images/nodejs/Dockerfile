FROM webera/base

ARG NODE_VERSION=20

# Install curl and dependencies
RUN apt update && apt install -y curl && \
    curl -fsSL https://raw.githubusercontent.com/tj/n/master/bin/n | bash -s $NODE_VERSION && \
    ln -s /usr/local/bin/node /usr/bin/node && \
    ln -s /usr/local/bin/npm /usr/bin/npm
