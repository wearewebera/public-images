FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Install base packages and create non-root user
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
     apt-utils \
     ca-certificates \
     curl \
     gnupg \
     lsb-release \
  && apt-get dist-upgrade -y \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && groupadd -g 1000 webera \
  && useradd -u 1000 -g webera -s /bin/bash -m webera

# Set security options
RUN echo "Acquire::http::Pipeline-Depth 0;" > /etc/apt/apt.conf.d/99fixbadproxy \
  && echo "Acquire::http::No-Cache true;" >> /etc/apt/apt.conf.d/99fixbadproxy \
  && echo "Acquire::BrokenProxy true;" >> /etc/apt/apt.conf.d/99fixbadproxy
