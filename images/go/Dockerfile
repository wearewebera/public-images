FROM webera/base

ARG GO_VERSION=1.24.5

# Install Go in a single layer
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        wget \
        git \
        build-essential && \
    ARCH=$(dpkg --print-architecture) && \
    if [ "$ARCH" = "amd64" ]; then ARCH="amd64"; elif [ "$ARCH" = "arm64" ]; then ARCH="arm64"; fi && \
    wget -q -O go.tar.gz https://go.dev/dl/go${GO_VERSION}.linux-${ARCH}.tar.gz && \
    tar -C /usr/local -xzf go.tar.gz && \
    rm go.tar.gz && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV PATH="/usr/local/go/bin:${PATH}" \
    GOPATH="/go" \
    GO111MODULE=on \
    CGO_ENABLED=0

# Create go directories
RUN mkdir -p /go/src /go/bin /go/pkg && \
    chown -R webera:webera /go

# Add health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=40s --retries=3 \
  CMD go version || exit 1

USER webera
WORKDIR /workspace
EXPOSE 8080