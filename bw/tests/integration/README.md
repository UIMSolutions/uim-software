# BW Integration Tests

Run endpoint-level integration checks:

```bash
cd bw
bash tests/integration/http_endpoints.sh
```

The script starts the service on a temporary port, executes HTTP requests against health, CRUD, search, query execution, and API catalog endpoints, then stops the service.
