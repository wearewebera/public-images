# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This repository contains Docker images for the Webera web hosting/development platform. All images are published to Docker Hub under the `webera/` namespace.

## Build Commands

Build images locally:
```bash
# Build a specific image (from repository root)
docker build -t webera/base ./images/base
docker build -t webera/apache ./images/apache
docker build -t webera/nginx ./images/nginx
docker build -t webera/php ./images/php
docker build -t webera/nodejs ./images/nodejs
docker build -t webera/python ./images/python
docker build -t webera/ssh ./images/ssh
docker build -t webera/wireguard-client ./images/wireguard-client
docker build -t webera/ollama ./images/ollama
```

Note: Images depend on `webera/base`, so build the base image first.

## Architecture

### Image Hierarchy
- **webera/base**: Ubuntu-based foundation image that all other images inherit from (except ollama)
- Service images build on top of base with specific functionality

### Service Communication
- Web servers (Apache/Nginx) run on port 8080
- PHP-FPM runs on port 9000 and is accessed via FastCGI
- SSH runs on port 10022
- Services run as non-root user `www-data` for security

### Build Pattern
All images follow a consistent pattern:
1. Copy assets directory containing scripts and configs
2. Run build.sh to install packages and configure the service
3. Clean up temporary files and apt caches
4. Set appropriate user and entrypoint

### CI/CD
- GitHub Actions workflows automatically build and push images to Docker Hub
- Images are built for both linux/amd64 and linux/arm64 platforms
- Weekly scheduled builds ensure images stay up-to-date
- Individual workflows exist for each image type, all using a shared build workflow