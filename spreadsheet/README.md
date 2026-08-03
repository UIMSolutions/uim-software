# Spreadsheet Module

This module provides a spreadsheet analytics service inspired by Tableau, implemented in D with vibe.d and structured around clean architecture boundaries.

## Architecture

- Domain: entities and repository contracts for spreadsheet workbooks and metrics.
- Application: use cases for creating, reading, updating, deleting, and summarizing spreadsheets.
- Infrastructure: in-memory persistence, configuration, and future adapters for SQL or NoSQL backends.
- Presentation: HTTP controllers and a lightweight web client.

## Run

```bash
dub run --config=defaultRun
```

If the package is launched from the workspace root, use:

```bash
dub --root spreadsheet run --config=defaultRun
```

## Test

```bash
dub test
```
