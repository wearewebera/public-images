# Security Policy

## Supported Versions

We release updates to our Docker images weekly and support the following versions:

| Version | Supported          |
| ------- | ------------------ |
| latest  | :white_check_mark: |
| ubuntu-24.04 | :white_check_mark: |
| ubuntu-22.04 | :x: (deprecated) |

## Reporting a Vulnerability

We take security seriously at Webera. If you discover a security vulnerability in our Docker images, please report it responsibly.

### How to Report

1. **DO NOT** open a public issue
2. Email security@webera.com with:
   - Description of the vulnerability
   - Steps to reproduce
   - Potential impact
   - Suggested fix (if any)

### What to Expect

- **Acknowledgment**: Within 48 hours
- **Initial Assessment**: Within 5 business days
- **Resolution Timeline**: Depends on severity
  - Critical: 1-2 days
  - High: 3-5 days
  - Medium: 1-2 weeks
  - Low: Next regular release

## Security Measures

Our images implement the following security best practices:

### 1. Base Image Security
- Uses official Ubuntu LTS releases
- Regular updates via automated weekly builds
- Minimal package installation
- Security-focused apt configuration

### 2. User Permissions
- All services run as non-root users
- Proper file ownership and permissions
- No sudo access in containers

### 3. Network Security
- Services use non-standard ports
- No unnecessary ports exposed
- Proper isolation between services

### 4. Build Process
- Automated security scanning in CI/CD
- Multi-architecture builds for consistency
- Signed images (coming soon)

### 5. Runtime Security
- Health checks for all services
- No hardcoded secrets or credentials
- Environment variable configuration

## Best Practices for Users

1. **Keep Images Updated**
   ```bash
   docker pull webera/[image]:latest
   ```

2. **Use Specific Tags**
   ```bash
   docker pull webera/php:8.3-ubuntu-24.04
   ```

3. **Scan Your Applications**
   ```bash
   docker scan webera/[image]
   ```

4. **Run as Non-Root**
   Our images already do this, but ensure your app does too

5. **Use Secrets Management**
   Never hardcode credentials in images or docker-compose files

## Security Checklist

When using our images:

- [ ] Using the latest version
- [ ] Not running containers as root
- [ ] Using environment variables for configuration
- [ ] Implementing proper network isolation
- [ ] Regular security scanning
- [ ] Monitoring container logs
- [ ] Using read-only volumes where possible
- [ ] Implementing resource limits

## Contact

- Security Issues: security@webera.com
- General Support: support@webera.com
- Documentation: https://github.com/wearewebera/public-images