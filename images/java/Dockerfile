FROM webera/base

ARG JAVA_VERSION=17

# Install OpenJDK and Maven in a single layer
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        openjdk-${JAVA_VERSION}-jdk \
        maven \
        gradle && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV MAVEN_HOME="/usr/share/maven" \
    GRADLE_HOME="/usr/share/gradle"

# Add health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=40s --retries=3 \
  CMD java -version || exit 1

USER webera
WORKDIR /workspace
EXPOSE 8080