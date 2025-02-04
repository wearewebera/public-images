FROM webera/base

SHELL ["/bin/bash", "--login", "-i", "-c"]

ARG NODE_VERSION=20

RUN apt update && \
    apt install curl -y && \
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

RUN source /root/.bashrc && nvm install $NODE_VERSION

ENV NVM_DIR="/root/.nvm"
ENV PATH="$NVM_DIR/versions/node/v20.18.2/bin:$PATH"
