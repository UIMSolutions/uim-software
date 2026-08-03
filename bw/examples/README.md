# BW Seed Data

This folder contains repeatable seed scripts for BW object catalogs.

## PostgreSQL

Run after the service has bootstrapped the schema or after applying the schema migration:

```bash
psql -d "$BW_POSTGRES_URL" -f bw/examples/sql/010_seed_bw_catalog.sql
```

## MongoDB

Run against the configured Mongo database:

```bash
mongosh "$BW_MONGO_URL/$BW_MONGO_DATABASE" --file bw/examples/mongo/010_seed_bw_catalog.js
```

Both scripts are idempotent and safe to execute multiple times.
