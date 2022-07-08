FROM python:3.8-slim-bullseye as base

# System setup
RUN apt-get update \
  && apt-get dist-upgrade -y \
  && apt-get install -y --no-install-recommends \
  git \
  ssh-client \
  software-properties-common \
  make \
  build-essential \
  ca-certificates \
  libpq-dev \
  python-dev \
  libsasl2-dev \
  gcc \
  unixodbc-dev \
  && apt-get clean \
  && rm -rf \
  /var/lib/apt/lists/* \
  /tmp/* \
  /var/tmp/*

# Env vars
ENV PYTHONIOENCODING=utf-8
ENV LANG=C.UTF-8

# Update python
RUN pip install --upgrade pip setuptools wheel --no-cache-dir
# Install packages
COPY requirements/requirements.txt ./
RUN pip install -r requirements.txt

WORKDIR /dbt
ADD ./cmd_executor.sh /dbt/
RUN chmod +x /dbt/cmd_executor.sh
ENTRYPOINT ["/dbt/cmd_executor.sh"]

FROM base as gcp
COPY requirements/requirements-gcp.txt ./
RUN pip install -r requirements-gcp.txt


