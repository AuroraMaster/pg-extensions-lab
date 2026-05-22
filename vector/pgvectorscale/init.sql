-- pgvectorscale — Timescale's vector extension built on top of pgvector.
-- Notable contribution: StreamingDiskANN, a disk-friendly ANN index that
-- trades a little recall for much better behavior on large indexes that
-- don't fit in RAM.

CREATE EXTENSION IF NOT EXISTS vector;          -- pgvector — the base type
CREATE EXTENSION IF NOT EXISTS vectorscale;     -- pgvectorscale — adds DiskANN

CREATE TABLE IF NOT EXISTS items (
    id        bigserial PRIMARY KEY,
    name      text       NOT NULL,
    embedding vector(384) NOT NULL
);

-- StreamingDiskANN index. Compared to HNSW it builds slower but its
-- memory footprint at query time is closer to "disk + small cache" than
-- "everything in RAM", which matters once your index exceeds the RAM
-- budget you're willing to spend.
CREATE INDEX IF NOT EXISTS items_embedding_diskann
    ON items USING diskann (embedding vector_l2_ops);
