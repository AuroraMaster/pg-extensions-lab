# Roadmap

Extension matrix. Each cell is one or more incremental PRs:
**B** = Build (Dockerfile)  ·  **C** = Compose example
**E** = `init.sql` / example queries  ·  **K** = Benchmark
**D** = Docs section in README

Legend:  `·` not started · `o` in progress · `x` done

| Category   | Extension          | B | C | E | K | D |
|------------|--------------------|---|---|---|---|---|
| base       | PG 17 image        | · | · | · | – | · |
| vector     | pgvector           | x | x | x | · | x |
| vector     | pgvecto.rs         | x | – | x | · | x |
| vector     | pgvectorscale      | x | – | x | · | x |
| graph      | Apache AGE         | · | · | · | · | · |
| graph      | pg_graphql         | · | · | · | – | · |
| graph      | pgrouting          | · | · | · | · | · |
| analytics  | duckdb_fdw         | · | · | · | · | · |
| analytics  | pg_analytics       | · | · | · | · | · |
| analytics  | hydra (columnar)   | · | · | · | · | · |
| analytics  | citus              | · | · | · | · | · |
| timeseries | timescaledb        | · | · | · | · | · |
| timeseries | pg_partman         | · | · | · | – | · |
| search     | pg_search (BM25)   | · | · | · | · | · |
| search     | zhparser           | · | · | · | – | · |
| search     | rum                | · | · | · | · | · |
| ml         | postgresml         | · | · | · | · | · |
| ml         | pg_embedding       | · | · | · | · | · |
| misc       | pg_cron            | · | – | · | – | · |
| misc       | pg_jsonschema      | · | – | · | – | · |
| misc       | pg_uuidv7          | · | – | · | – | · |
| misc       | pg_repack          | · | – | · | – | · |
| misc       | pgaudit            | · | – | · | – | · |
| compose    | all-in-one         | – | · | – | – | · |
| compose    | vector-only        | – | · | – | – | · |
| compose    | analytics-only     | – | · | – | – | · |
| compose    | graph-only         | – | · | – | – | · |

## Conventions

- Base image is `postgres:17-bookworm`. Extensions that ship as a Postgres
  image themselves (e.g. `timescale/timescaledb`) inherit from upstream.
- One extension per directory under the category folder.
- Each directory should have `Dockerfile`, `init.sql`, `README.md` and an
  optional `bench/` subdir.
- Compose stacks live in `compose/` and combine multiple images.

## Non-goals

- Production-grade configs. The point is **research**, not deployment.
- Exhaustive extension coverage. Only widely-used ones earn a slot.
