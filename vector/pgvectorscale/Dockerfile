FROM pgxlab/base:17

ARG PGVECTORSCALE_VERSION=0.5.1

# pgvectorscale builds on top of pgvector — install both.
RUN git clone --branch v0.8.0 --depth 1 \
        https://github.com/pgvector/pgvector.git /tmp/pgvector \
 && (cd /tmp/pgvector && make && make install) \
 && rm -rf /tmp/pgvector

# Build pgvectorscale itself.
RUN curl -fSL --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs \
        | sh -s -- -y --default-toolchain stable --profile minimal \
 && . "$HOME/.cargo/env" \
 && cargo install --locked cargo-pgrx --version 0.12.5 \
 && cargo pgrx init --pg17 $(which pg_config) \
 && git clone --branch ${PGVECTORSCALE_VERSION} --depth 1 \
        https://github.com/timescale/pgvectorscale.git /tmp/pgvectorscale \
 && (cd /tmp/pgvectorscale/pgvectorscale && cargo pgrx install --release) \
 && rm -rf /tmp/pgvectorscale "$HOME/.cargo" "$HOME/.rustup"

COPY init.sql /docker-entrypoint-initdb.d/10-pgvectorscale.sql
