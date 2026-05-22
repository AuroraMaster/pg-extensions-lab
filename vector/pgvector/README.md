# pgvector

`pgvector` adds a `vector` data type to PostgreSQL, plus exact and approximate
nearest-neighbor search. It is the most widely deployed vector extension for
PG and is a reasonable starting point for anyone evaluating in-database vector
search.

## What's here

| File                  | What it is                                            |
|-----------------------|--------------------------------------------------------|
| `Dockerfile`          | Builds `pgxlab/pgvector:17-0.8` on top of the base.    |
| `init.sql`            | Creates the extension and a tiny `items` example table.|
| `docker-compose.yml`  | One-service compose stack with a named volume.         |

## Up and running

```bash
docker compose up -d
psql postgresql://postgres:pgxlab@localhost:5432/lab -c '\dx vector'
```

## Index choice cheat sheet

- **IVFFlat** — fast to build, sensitive to clustering; needs `ANALYZE`
  before queries are good. Tune `lists` ≈ √N for medium tables.
- **HNSW** — slower to build, generally better recall/latency on small-to-
  medium tables. No `probes` knob at query time, so you tune at index time
  (`m`, `ef_construction`).

The default `init.sql` builds an HNSW index because the lab is read-heavy.

## Limits worth knowing

- `vector(N)` is capped at 16,000 dimensions.
- HNSW build is single-threaded per index in 0.8 (parallel build is on the
  roadmap upstream).
- Distance functions: L2 (`<->`), inner product (`<#>`), cosine (`<=>`).
  Pick the operator class that matches your distance.

## References

- https://github.com/pgvector/pgvector — upstream
- https://github.com/pgvector/pgvector#hnsw — HNSW docs
