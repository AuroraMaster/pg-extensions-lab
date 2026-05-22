# pg-extensions-lab

> A research workspace for evaluating, combining and benchmarking modern
> PostgreSQL extensions — vector search, graph, columnar analytics, full-text,
> ML, timeseries — all Dockerized for reproducible experiments.

PostgreSQL is no longer just an OLTP database. Over the past few years it has
become a *platform*: extensions like `pgvector`, `Apache AGE`, `TimescaleDB`,
`pg_search`, `pg_analytics`, `Citus` and `PostgresML` push it into domains that
used to require separate systems. This lab collects them in one place, exposes
each as a runnable Docker image, and ships small benchmarks so the trade-offs
are visible side-by-side.

## Goals

1. **Reproducible** — every extension has a pinned Dockerfile, no "works on
   my machine" surprises.
2. **Composable** — compose files combine multiple extensions to test real
   workloads (e.g. vector + full-text hybrid search, graph + analytics).
3. **Measurable** — small but honest benchmarks for each extension category.
4. **Up-to-date** — tracks the current major PostgreSQL release (PG 17).

## Layout (work in progress)

```
base/                 PG 17 base image with build deps
vector/               pgvector, pgvecto.rs, pgvectorscale
graph/                Apache AGE, pg_graphql, pgrouting
analytics/            duckdb_fdw, pg_analytics, hydra, citus
timeseries/           TimescaleDB, pg_partman
search/               pg_search (BM25), zhparser, rum
ml/                   PostgresML, pg_embedding
extensions-misc/      pg_cron, pg_jsonschema, pg_uuidv7, pg_repack, pgaudit
compose/              ready-to-run docker-compose stacks
benchmarks/           per-category perf scripts
```

## Status

This repo is being seeded — see [`ROADMAP.md`](./ROADMAP.md) for the planned
extension matrix and which slots are filled.

## License

MIT — see [`LICENSE`](./LICENSE).
