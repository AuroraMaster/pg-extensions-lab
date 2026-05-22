FROM pgxlab/base:17

ARG PGVECTOR_VERSION=v0.8.0

RUN git clone --branch ${PGVECTOR_VERSION} --depth 1 \
        https://github.com/pgvector/pgvector.git /tmp/pgvector \
 && cd /tmp/pgvector \
 && make OPTFLAGS="" \
 && make install \
 && rm -rf /tmp/pgvector

# Make the extension available by default in the 'lab' database.
COPY init.sql /docker-entrypoint-initdb.d/10-pgvector.sql
