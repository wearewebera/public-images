# Contributing to Webera Public Images

Thank you for your interest in contributing to Webera's public Docker images! We welcome contributions from the community.

## Code of Conduct

By participating in this project, you agree to abide by our Code of Conduct:
- Be respectful and inclusive
- Welcome newcomers and help them get started
- Focus on what is best for the community
- Show empathy towards other community members

## How to Contribute

### Reporting Issues

1. Check if the issue already exists
2. Create a new issue with:
   - Clear title and description
   - Steps to reproduce (if applicable)
   - Expected vs actual behavior
   - Environment details (OS, Docker version)

### Suggesting Enhancements

1. Open an issue with the `enhancement` label
2. Clearly describe the enhancement and its benefits
3. Provide examples of how it would be used

### Pull Requests

1. **Fork the Repository**
   ```bash
   git clone https://github.com/wearewebera/public-images.git
   cd public-images
   ```

2. **Create a Branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make Your Changes**
   - Follow existing code style
   - Update documentation if needed
   - Add tests if applicable

4. **Test Your Changes**
   ```bash
   # Build the affected image
   docker build -t webera/image-name ./images/image-name
   
   # Test the image
   docker run --rm webera/image-name
   ```

5. **Commit Your Changes**
   ```bash
   git add .
   git commit -m "feat: add amazing feature"
   ```

6. **Push and Create PR**
   ```bash
   git push origin feature/your-feature-name
   ```

## Development Guidelines

### Dockerfile Best Practices

1. **Use Specific Versions**
   ```dockerfile
   FROM ubuntu:24.04  # Good
   FROM ubuntu        # Bad
   ```

2. **Minimize Layers**
   ```dockerfile
   # Good
   RUN apt-get update && \
       apt-get install -y package1 package2 && \
       apt-get clean && \
       rm -rf /var/lib/apt/lists/*
   
   # Bad
   RUN apt-get update
   RUN apt-get install -y package1
   RUN apt-get install -y package2
   ```

3. **Run as Non-Root**
   ```dockerfile
   USER webera
   ```

4. **Add Health Checks**
   ```dockerfile
   HEALTHCHECK --interval=30s --timeout=3s \
     CMD curl -f http://localhost:8080/health || exit 1
   ```

### Commit Message Format

We use conventional commits:

- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation changes
- `style:` Code style changes
- `refactor:` Code refactoring
- `test:` Test additions/changes
- `chore:` Maintenance tasks

Examples:
```
feat: add Ruby 3.3 support
fix: correct PHP memory limit setting
docs: update README with new examples
```

### Testing

Before submitting a PR:

1. **Build the Image**
   ```bash
   docker build -t test-image ./images/your-image
   ```

2. **Run Basic Tests**
   ```bash
   # Check if the image runs
   docker run --rm test-image
   
   # Check installed versions
   docker run --rm test-image [command] --version
   ```

3. **Test with Examples**
   ```bash
   cd examples/your-example
   docker-compose up
   ```

### Documentation

Update documentation for:
- New features or images
- Changed behavior
- New examples
- Configuration options

## Image Guidelines

### New Images Should:
- Inherit from `webera/base`
- Use Ubuntu 24.04 as the base
- Run services as non-root
- Expose only necessary ports
- Include health checks
- Have minimal dependencies
- Include clear documentation

### Example Structure:
```
images/new-image/
├── Dockerfile
└── assets/
    ├── build.sh
    └── config-files/
```

## Review Process

1. **Automated Checks**
   - Docker build success
   - Security scanning
   - Linting

2. **Manual Review**
   - Code quality
   - Best practices
   - Documentation
   - Testing

3. **Merge Requirements**
   - All checks pass
   - Approved by maintainer
   - No conflicts

## Release Process

1. Changes are merged to `main`
2. Weekly automated builds push to Docker Hub
3. Images are tagged with:
   - `latest`
   - `ubuntu-24.04`
   - Git SHA
   - Software version (where applicable)

## Getting Help

- 💬 [GitHub Discussions](https://github.com/wearewebera/public-images/discussions)
- 📧 developers@webera.com
- 📚 [Documentation](https://github.com/wearewebera/public-images/wiki)

## Recognition

Contributors will be:
- Listed in our CONTRIBUTORS.md file
- Mentioned in release notes
- Given credit in commit messages

Thank you for helping make Webera's Docker images better!