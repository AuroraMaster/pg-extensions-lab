# pgvectorscale

`pgvectorscale` is Timescale's vector extension that sits *on top of*
`pgvector` (you need both installed). Its headline contribution is
**StreamingDiskANN**, a disk-friendly ANN index.

## Why DiskANN matters

HNSW and IVFFlat both assume the index is small enough to live mostly in
RAM during queries. Once you get into the "100M vectors × 768 dims"
territory that's no longer cheap.

StreamingDiskANN trades a little recall for:

- **Smaller working set** — most of the graph sits on disk; only a hot
  subset is in cache.
- **Predictable query latency** under memory pressure — HNSW degrades
  badly when paged; DiskANN was designed with that case in mind.
- **Faster build** for the same recall target on large indexes.

## What's here

| File          | Purpose                                              |
|---------------|------------------------------------------------------|
| `Dockerfile`  | Build `pgvector` + `pgvectorscale` from source.      |
| `init.sql`    | Create extensions + sample table + DiskANN index.   |

## A note on build time

`pgvectorscale` is built with `pgrx`, which requires a Rust toolchain and
takes 5–10 minutes to compile on first build. We deliberately install +
remove `~/.cargo` and `~/.rustup` in the same `RUN` layer so the toolchain
doesn't bloat the final image.

## When to use it

- Index would be > tens of GB on disk.
- Query latency under memory pressure matters more than peak recall.
- You're already on Timescale's stack (some warehousing fits naturally
  alongside StreamingDiskANN).

When **not** to use it:

- Small index, fits in RAM — just use pgvector HNSW, you'll get the same
  result with less moving parts.
- You can't afford the build-time toolchain (consider Timescale Cloud's
  prebuilt image).

## References

- Timescale blog, StreamingDiskANN announcement (2024)
- DiskANN paper: Subramanya et al., NeurIPS 2019
- https://github.com/timescale/pgvectorscale
