FROM webera/base

RUN apt-get update  \
 && apt-get install -y --no-install-recommends \
    ca-certificates less vim curl git python3 python-is-python3 \
    python3-software-properties python3-dev python3-pip python3-venv \
    python3-dateutil python3-urllib3 python3-wheel python3-requests \
    gunicorn python3-poetry\
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* 


 RUN pip install --upgrade pip --break-system-packages
 RUN pip install --upgrade poetry --break-system-packages