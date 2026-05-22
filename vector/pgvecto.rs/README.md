# pgvecto.rs

`pgvecto.rs` is a Rust implementation of in-database vector search by
TensorChord. The interesting properties relative to `pgvector` are:

1. **Filter-aware ANN** — the index walk takes Postgres `WHERE` predicates
   into account, so `WHERE tenant = $1 ORDER BY embedding <-> $2 LIMIT 10`
   doesn't fall off a cliff when filter selectivity is low.
2. **Quantization** built in — scalar and product quantization configured
   per-index; useful when embeddings don't fit in RAM.
3. **Async indexing** — index builds run on a background thread, so DDL
   doesn't block writes.

## What's here

| File          | What it is                                       |
|---------------|---------------------------------------------------|
| `Dockerfile`  | Installs the prebuilt `.deb` matching PG 17.      |
| `init.sql`    | Creates the extension + sample `items` table.    |

## Operator class names (where pgvector ≠ pgvecto.rs)

| Distance        | pgvector             | pgvecto.rs              |
|-----------------|----------------------|-------------------------|
| L2              | `vector_l2_ops`      | `vector_l2_ops`         |
| Cosine          | `vector_cosine_ops`  | `vector_cos_ops`        |
| Inner product   | `vector_ip_ops`      | `vector_dot_ops`        |

Switching extensions does **not** mean swapping a single line — the index
operator names differ.

## When to prefer pgvecto.rs over pgvector

- You have **selective `WHERE` filters** on the same query as the ANN.
- Embedding count × dimension >> RAM (quantization saves you).
- You need to rebuild indexes without blocking writes.

When **not** to prefer it:

- You want the absolute smallest install footprint — pgvector is simpler.
- The ecosystem around you assumes pgvector (LangChain etc. — adapters
  exist for both but pgvector is the path of least resistance).

## References

- https://github.com/tensorchord/pgvecto.rs
- TensorChord blog: filter-aware ANN walkthrough
