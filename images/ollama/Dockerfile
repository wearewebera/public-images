FROM ollama/ollama

# Set up user
USER ollama
WORKDIR /home/ollama

# Expose Ollama port
EXPOSE 11434

# Set environment variables
ENV OLLAMA_HOST=0.0.0.0

# Add health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD ollama list || exit 1

# The model will be pulled on first use or can be pre-pulled via init script
# To pre-pull models, create an init script or use docker-compose

