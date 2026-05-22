# PG 17 base image with build dependencies pre-installed.
# Other extension images inherit from this one to avoid re-installing
# build-essential / clang / pg server-dev for every extension.

FROM postgres:17-bookworm

ARG PG_MAJOR=17

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
        build-essential \
        ca-certificates \
        clang \
        cmake \
        curl \
        git \
        libcurl4-openssl-dev \
        libicu-dev \
        libssl-dev \
        pkg-config \
        postgresql-server-dev-${PG_MAJOR} \
 && rm -rf /var/lib/apt/lists/*

# Common runtime tunables — small, sensible defaults for a research workload.
ENV POSTGRES_HOST_AUTH_METHOD=trust \
    PGDATA=/var/lib/postgresql/data

# Re-export the default postgres entrypoint; downstream images add init.sql.
