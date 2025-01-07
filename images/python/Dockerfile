FROM webera/base

RUN apt update && \
    apt install -y software-properties-common \
                   python3 \
                   python3-pip \
                   python3-venv \  # Adds support for virtual environments
                   python3-dev \   # Provides headers for compiling Python packages
                   build-essential \ # Tools for compiling native extensions
                   curl

# Install Poetry
RUN curl -sSL https://install.python-poetry.org | POETRY_HOME=/etc/poetry python3 -

# Add Poetry to PATH
ENV PATH="/etc/poetry/bin:${PATH}"
