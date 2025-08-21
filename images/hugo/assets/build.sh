#!/bin/sh
set -e

# Get build arguments from environment
HUGO_VERSION=${HUGO_VERSION:-0.140.2}
GO_VERSION=${GO_VERSION:-1.24.5}
DART_SASS_VERSION=${DART_SASS_VERSION:-1.83.0}

# Detect architecture
ARCH=$(dpkg --print-architecture)
if [ "$ARCH" = "amd64" ]; then 
    HUGO_ARCH="linux-amd64"
    GO_ARCH="amd64"
    DART_ARCH="x64"
elif [ "$ARCH" = "arm64" ]; then 
    HUGO_ARCH="linux-arm64"
    GO_ARCH="arm64"
    DART_ARCH="arm64"
else
    echo "Unsupported architecture: $ARCH"
    exit 1
fi

#
# Install essential packages for CI/CD
#
apt-get update
apt-get install -y --no-install-recommends \
    wget \
    curl \
    git \
    ca-certificates \
    build-essential \
    openssh-client \
    tar \
    gzip

#
# Install Go
#
echo "Installing Go ${GO_VERSION}..."
wget -q -O go.tar.gz https://go.dev/dl/go${GO_VERSION}.linux-${GO_ARCH}.tar.gz
tar -C /usr/local -xzf go.tar.gz
rm go.tar.gz

# Verify Go installation
/usr/local/go/bin/go version

#
# Install Hugo Extended
#
echo "Installing Hugo Extended ${HUGO_VERSION}..."
wget -q -O hugo.tar.gz https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_${HUGO_ARCH}.tar.gz
tar -C /tmp -xzf hugo.tar.gz
mv /tmp/hugo /usr/local/bin/hugo
chmod +x /usr/local/bin/hugo
rm hugo.tar.gz

# Verify Hugo installation
/usr/local/bin/hugo version

#
# Install Dart Sass Embedded
#
echo "Installing Dart Sass ${DART_SASS_VERSION}..."
if [ "$ARCH" = "amd64" ]; then
    DART_SASS_URL="https://github.com/sass/dart-sass/releases/download/${DART_SASS_VERSION}/dart-sass-${DART_SASS_VERSION}-linux-x64.tar.gz"
elif [ "$ARCH" = "arm64" ]; then
    DART_SASS_URL="https://github.com/sass/dart-sass/releases/download/${DART_SASS_VERSION}/dart-sass-${DART_SASS_VERSION}-linux-arm64.tar.gz"
fi

wget -q -O dart-sass.tar.gz "$DART_SASS_URL"
tar -C /tmp -xzf dart-sass.tar.gz
mv /tmp/dart-sass/sass /usr/local/bin/sass
chmod +x /usr/local/bin/sass
rm -rf dart-sass.tar.gz /tmp/dart-sass

# Verify Dart Sass installation
/usr/local/bin/sass --version

#
# Configure Git for CI environments
#
git config --global --add safe.directory '*'
git config --global user.email "ci@example.com"
git config --global user.name "CI Bot"

#
# Clean up
#
apt-get clean
rm -rf /var/lib/apt/lists/*

echo "Hugo environment setup complete!"
echo "- Hugo Extended: $(hugo version)"
echo "- Go: $(go version)"
echo "- Git: $(git --version)"
echo "- Dart Sass: $(sass --version)"