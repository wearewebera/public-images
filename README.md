# Webera Public Docker Images

[![Build All Images](https://github.com/wearewebera/public-images/actions/workflows/full.yml/badge.svg)](https://github.com/wearewebera/public-images/actions/workflows/full.yml)

Open-source Docker images built on the latest Ubuntu LTS release, optimized for web development and hosting. All images are available on [Docker Hub](https://hub.docker.com/u/webera).

## 🚀 Quick Start

```bash
# Pull an image
docker pull webera/php:latest

# Run a container
docker run -d -p 8080:8080 webera/apache

# Use with docker-compose
docker-compose up -d
```

## 📦 Available Images

| Image | Description | Size | Ports |
|-------|-------------|------|-------|
| `webera/base` | Ubuntu 24.04 base with essential tools | ~80MB | - |
| `webera/apache` | Apache 2.4 web server with PHP support | ~150MB | 8080 |
| `webera/nginx` | Nginx web server | ~140MB | 8080 |
| `webera/php` | PHP-FPM with common extensions | ~200MB | 9000 |
| `webera/nodejs` | Node.js LTS runtime | ~180MB | 3000 |
| `webera/python` | Python 3 with Poetry | ~220MB | - |
| `webera/hugo` | Hugo Extended with Go & Dart Sass | ~450MB | 1313 |
| `webera/ssh` | SSH server with restricted commands | ~120MB | 10022 |
| `webera/wireguard-client` | WireGuard VPN client | ~100MB | - |
| `webera/ollama` | Ollama with qwen2.5-coder model | ~5GB | 11434 |

## 🏗️ Architecture

All images (except `ollama`) inherit from `webera/base`, providing:
- Latest Ubuntu 24.04 LTS
- Non-root user (`webera` or `www-data`)
- Security hardening
- Minimal attack surface
- Multi-architecture support (amd64, arm64)

## 📖 Usage Examples

### PHP Web Application

```yaml
# docker-compose.yml
version: '3.8'
services:
  web:
    image: webera/apache:latest
    ports:
      - "8080:8080"
    volumes:
      - ./src:/var/www/public_html
    environment:
      - PHP_FPM_HOST=php
      
  php:
    image: webera/php:latest
    volumes:
      - ./src:/var/www/public_html
```

### Node.js Application

```bash
docker run -d \
  -p 3000:3000 \
  -v $(pwd):/app \
  -w /app \
  webera/nodejs:latest \
  npm start
```

### Python Development

```bash
docker run -it \
  -v $(pwd):/workspace \
  -w /workspace \
  webera/python:latest \
  poetry install
```

### Hugo Static Site

```bash
# Local development server
docker run -d \
  -p 1313:1313 \
  -v $(pwd):/site \
  webera/hugo:latest \
  hugo server --bind 0.0.0.0

# Build for production
docker run --rm \
  -v $(pwd):/site \
  webera/hugo:latest \
  hugo --minify
```

### Hugo in GitHub Actions

```yaml
name: Build Hugo Site
on: [push]

jobs:
  build:
    runs-on: ubuntu-latest
    container: 
      image: webera/hugo:latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0  # For .GitInfo and .Lastmod
          
      - name: Build site
        run: hugo --minify
        
      - name: Upload artifacts
        uses: actions/upload-artifact@v4
        with:
          name: public
          path: public/
```

## 🔧 Environment Variables

### Apache (`webera/apache`)
- `APACHE_PORT`: Server port (default: 8080)
- `APACHE_HOME`: Document root (default: /var/www/public_html)
- `PHP_FPM_HOST`: PHP-FPM hostname (default: localhost)
- `PHP_FPM_PORT`: PHP-FPM port (default: 9000)

### PHP (`webera/php`)
- `PHP_MEMORY_LIMIT`: Memory limit (default: 128M)
- `PHP_MAX_EXECUTION_TIME`: Max execution time (default: 30)
- `PHP_UPLOAD_MAX_FILESIZE`: Upload limit (default: 2M)

### Node.js (`webera/nodejs`)
- `NODE_ENV`: Environment (default: production)
- `PORT`: Application port (default: 3000)

### Hugo (`webera/hugo`)
- `HUGO_ENVIRONMENT`: Build environment (default: production)
- `HUGO_CACHEDIR`: Cache directory (default: /tmp/hugo_cache)
- `PORT`: Server port (default: 1313)

## 🏷️ Versioning

We provide multiple tags for flexibility:

- `latest`: Latest stable release
- `ubuntu-24.04`: Specific Ubuntu version
- `{version}-ubuntu-24.04`: Specific software + Ubuntu version
- `{git-sha}`: Specific build from commit

Example:
```bash
docker pull webera/php:8.3-ubuntu-24.04
docker pull webera/nodejs:20-ubuntu-24.04
```

## 🔒 Security

- All images run as non-root users
- Regular security updates via automated weekly builds
- Minimal package installation
- No unnecessary services or ports
- Security scanning in CI/CD pipeline

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md).

### Building Locally

```bash
# Clone the repository
git clone https://github.com/wearewebera/public-images.git
cd public-images

# Build base image first
docker build -t webera/base ./images/base

# Build other images
docker build -t webera/php ./images/php
```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

- 📚 [Documentation](https://github.com/wearewebera/public-images/wiki)
- 🐛 [Issue Tracker](https://github.com/wearewebera/public-images/issues)
- 💬 [Discussions](https://github.com/wearewebera/public-images/discussions)
- 🌐 [Webera Website](https://webera.com)

## 🚦 Build Status

| Image | Status |
|-------|--------|
| Base | ![Base](https://github.com/wearewebera/public-images/actions/workflows/image-base.yml/badge.svg) |
| Apache | ![Apache](https://github.com/wearewebera/public-images/actions/workflows/image-apache.yml/badge.svg) |
| Nginx | ![Nginx](https://github.com/wearewebera/public-images/actions/workflows/image-nginx.yml/badge.svg) |
| PHP | ![PHP](https://github.com/wearewebera/public-images/actions/workflows/image-php.yml/badge.svg) |
| Node.js | ![Node.js](https://github.com/wearewebera/public-images/actions/workflows/image-nodejs.yml/badge.svg) |
| Python | ![Python](https://github.com/wearewebera/public-images/actions/workflows/image-python.yml/badge.svg) |

---

Made with ❤️ by [Webera](https://webera.com)