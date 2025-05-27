FROM webera/base

ARG RUBY_VERSION=3.2

# Install Ruby and Bundler in a single layer
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ruby-full \
        ruby-dev \
        build-essential \
        libssl-dev \
        libreadline-dev \
        zlib1g-dev && \
    gem install bundler && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV GEM_HOME="/usr/local/bundle" \
    BUNDLE_SILENCE_ROOT_WARNING=1 \
    BUNDLE_APP_CONFIG="$GEM_HOME" \
    PATH="$GEM_HOME/bin:$PATH"

# Create gem directories
RUN mkdir -p "$GEM_HOME" && \
    chown -R webera:webera "$GEM_HOME"

# Add health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=40s --retries=3 \
  CMD ruby --version || exit 1

USER webera
WORKDIR /workspace
EXPOSE 3000