FROM webera/base

RUN apt update && \
    apt install -y software-properties-common \
                   python3-pip \
                   curl

# Install Poetry
RUN curl -sSL https://install.python-poetry.org | POETRY_HOME=/etc/poetry python3 -

# Add Poetry to PATH
ENV PATH="/etc/poetry/bin:${PATH}"