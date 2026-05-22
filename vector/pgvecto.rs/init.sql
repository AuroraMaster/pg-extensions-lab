-- pgvecto.rs — Rust-implemented vector extension with HNSW and quantization.
-- Distinguishing features vs pgvector:
--   * single-precision and scalar/product quantization out of the box
--   * filter-aware ANN search (filter cost folded into index walk)
--   * different operator class names

CREATE EXTENSION IF NOT EXISTS vectors;

CREATE TABLE IF NOT EXISTS items (
    id        bigserial PRIMARY KEY,
    name      text       NOT NULL,
    embedding vector(384) NOT NULL
);

-- HNSW index; note operator class differs from pgvector (no `vector_l2_ops`).
CREATE INDEX IF NOT EXISTS items_embedding_hnsw
    ON items USING vectors (embedding vector_l2_ops)
    WITH (options = $$
        [indexing.hnsw]
        m = 16
        ef_construction = 64
    $$);
