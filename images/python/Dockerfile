FROM webera/base

# Install Python and Poetry in a single layer
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        software-properties-common \
        python3 \
        python3-pip \
        python3-venv \
        python3-dev \
        build-essential \
        curl && \
    curl -sSL https://install.python-poetry.org | POETRY_HOME=/etc/poetry python3 - && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV PATH="/etc/poetry/bin:${PATH}" \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    POETRY_VIRTUALENVS_IN_PROJECT=true \
    POETRY_NO_INTERACTION=1

USER webera
WORKDIR /workspace
