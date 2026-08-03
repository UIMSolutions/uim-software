# Administration Guide

## Service Operations

- Start service: `dub run`
- Run tests: `dub test`

## Runtime Settings

- `PP_HOST`: HTTP bind host.
- `PP_PORT`: HTTP bind port.
- `PP_WEB_ROOT`: web UI path.

## Operational Concerns

- Current adapter is in-memory and intended for development/testing.
- Add a DB-backed adapter by implementing `PPRepository` and replacing wiring in the container.
- Set up observability and access controls at gateway or service middleware.
