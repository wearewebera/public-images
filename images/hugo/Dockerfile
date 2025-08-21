FROM webera/base

ARG HUGO_VERSION=0.140.2
ARG GO_VERSION=1.24.5
ARG DART_SASS_VERSION=1.83.0

# Copy assets for build
COPY assets /tmp/assets

# Install everything in a single layer for smaller image size
RUN chmod +x /tmp/assets/build.sh && bash /tmp/assets/build.sh && rm -rf /tmp/assets

# Set environment variables for Hugo and Go
ENV HUGO_CACHEDIR=/tmp/hugo_cache \
    HUGO_ENVIRONMENT=production \
    GO111MODULE=on \
    GOCACHE=/go/cache \
    GOMODCACHE=/go/pkg/mod \
    PATH="/usr/local/go/bin:/usr/local/bin:${PATH}" \
    PORT=1313

# Create necessary directories with proper permissions
RUN mkdir -p /site /go/cache /go/pkg/mod /tmp/hugo_cache && \
    chown -R webera:webera /site /go /tmp/hugo_cache

# Add comprehensive health check for CI environments
HEALTHCHECK --interval=30s --timeout=3s --start-period=40s --retries=3 \
  CMD hugo version && go version && git --version || exit 1

USER webera
WORKDIR /site
EXPOSE 1313