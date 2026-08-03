# Administration

## Runtime configuration

- Default host: 0.0.0.0
- Default port: 8080
- Repository type: memory

## Operational notes

- The service is intentionally structured with a repository port so a production persistence adapter can be introduced without changing the domain or application layers.
- The current implementation uses an in-memory repository suitable for demos and tests.
