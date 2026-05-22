# vector/

In-database vector search. The pitch is well-rehearsed by now: keep your
embeddings next to the rest of your data so retrieval, filters and joins
happen in one place. The question this directory tries to answer is
*which* vector extension fits *which* shape of workload.

## What's here

| Extension       | Built on   | Headline feature                              |
|-----------------|------------|------------------------------------------------|
| `pgvector`      | scratch    | Simplest, widest ecosystem, default choice    |
| `pgvecto.rs`    | scratch    | Filter-aware ANN, quantization, async builds  |
| `pgvectorscale` | pgvector   | StreamingDiskANN — disk-friendly index        |

## How to choose, in one paragraph

If you have **less than a few million vectors** and they fit in RAM,
**pgvector with HNSW** is the right boring answer. If you need to
**combine ANN with selective filters** (multi-tenant, time-bounded,
permissions) and watch the index fall off a cliff under low filter
selectivity, **pgvecto.rs** is what you want. If your index **exceeds the
RAM budget**, look at **pgvectorscale's DiskANN**.

These trade-offs are surveyed in detail in each subdirectory's README.

## Things to know across all three

- **Distance functions** differ by use case: cosine for normalized text
  embeddings, L2 for image embeddings, inner product when the model
  already does the cosine normalization for you.
- **Operator class names differ** between extensions — see each subdir's
  README for the mapping. You can't paste a query from a pgvector tutorial
  into a pgvecto.rs setup unchanged.
- **Index build is the slow operation**, not query. Build once on bulk
  load, then `ANALYZE`.

## Open questions

- How well does each handle deletions + recall over time? (TODO: benchmark)
- Quantization sweet spots — at what dimension does product quantization
  start to bite recall noticeably?
- Multi-vector (per-row collection) workflows — none of these handle that
  natively; you fan out to one row per vector.
