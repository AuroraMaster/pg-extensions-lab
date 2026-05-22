FROM pgxlab/base:17

ARG PGVECTORS_VERSION=v0.4.0

# pgvecto.rs ships prebuilt .deb packages per PG major version.
# We pull the matching one and install — much faster than a source build.
RUN curl -fSL \
        "https://github.com/tensorchord/pgvecto.rs/releases/download/${PGVECTORS_VERSION}/vectors-pg17_${PGVECTORS_VERSION#v}_amd64.deb" \
        -o /tmp/pgvectors.deb \
 && dpkg -i /tmp/pgvectors.deb \
 && rm -f /tmp/pgvectors.deb

# Required for the extension to load.
RUN echo "shared_preload_libraries = 'vectors.so'" >> /usr/share/postgresql/postgresql.conf.sample

COPY init.sql /docker-entrypoint-initdb.d/10-pgvectors.sql
