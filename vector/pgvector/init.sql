-- pgvector — exact + approximate nearest neighbor search inside Postgres.
-- This script runs on first container boot via docker-entrypoint-initdb.d.

CREATE EXTENSION IF NOT EXISTS vector;

-- A tiny example table so 'docker compose up' lands you in something runnable.
CREATE TABLE IF NOT EXISTS items (
    id    bigserial PRIMARY KEY,
    name  text       NOT NULL,
    embedding vector(384)  -- 384 = sentence-transformers all-MiniLM-L6-v2 size
);

-- Two index types worth knowing about:
--   ivfflat  — fast to build, requires ANALYZE, needs `lists` tuning.
--   hnsw     — slower to build, higher quality recall, no probe knob at query time.
-- We default to HNSW with conservative params; override per workload.
CREATE INDEX IF NOT EXISTS items_embedding_hnsw
    ON items USING hnsw (embedding vector_l2_ops)
    WITH (m = 16, ef_construction = 64);
