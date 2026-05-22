# base — PG 17 build image

A thin layer over the official `postgres:17-bookworm` image that pre-installs
the build dependencies most extensions need (`clang`, `cmake`,
`postgresql-server-dev-17`, etc.).

Every other extension image in this repo inherits from `pgxlab/base:17` so
each Dockerfile stays short.

## Build

```bash
docker build -t pgxlab/base:17 .
```

## Use

```dockerfile
FROM pgxlab/base:17

# extension-specific build steps
```
