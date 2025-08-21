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
    gzip \
    rsync \
    jq \
    zip \
    unzip \
    python3 \
    python3-pip \
    python3-venv

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
tar -C /usr/local -xzf dart-sass.tar.gz
# Keep the entire dart-sass directory structure intact
chmod +x /usr/local/dart-sass/sass
ln -s /usr/local/dart-sass/sass /usr/local/bin/sass
rm -rf dart-sass.tar.gz

# Verify Dart Sass installation
/usr/local/bin/sass --version

#
# Install AWS CLI v2
#
echo "Installing AWS CLI v2..."
if [ "$ARCH" = "amd64" ]; then
    AWS_CLI_ARCH="x86_64"
elif [ "$ARCH" = "arm64" ]; then
    AWS_CLI_ARCH="aarch64"
fi

curl -sL "https://awscli.amazonaws.com/awscli-exe-linux-${AWS_CLI_ARCH}.zip" -o "awscliv2.zip"
unzip -q awscliv2.zip
./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli
rm -rf awscliv2.zip aws/

# Verify AWS CLI installation
/usr/local/bin/aws --version

#
# Install other deployment tools via pip
#
echo "Installing deployment tools..."
python3 -m pip install --no-cache-dir --break-system-packages \
    s3cmd \
    azure-cli

#
# Install GitHub CLI
#
echo "Installing GitHub CLI..."
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null
apt-get update
apt-get install -y gh

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
echo "- AWS CLI: $(aws --version)"
echo "- GitHub CLI: $(gh --version)"
echo "- rsync: $(rsync --version | head -1)"