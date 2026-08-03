# Administration Guide

## Service Start

```bash
cd rpm
dub run
```

## Configuration

Supported environment variables:

- `RPM_HOST`
- `RPM_PORT`
- `RPM_WEB_ROOT`
- `RPM_REPOSITORY`

## Health Checks

- `GET /health`
- `GET /api/v1/health`

## Access Control

- All routes require `Authorization: Bearer <token>`.
- Write routes require `X-RPM-Roles` containing one of:
  - `rpm.admin`
  - `rpm.write`
  - `<objectType>.write`

## Operations Monitoring

Track executed operations in:

- `transfer-orders`
- `shipment-orders`
- `return-orders`
- `cleaning-orders`
- `repair-orders`
- `quality-inspections`
- `telemetry-events`
- `audit-entries`

## Backup Strategy (Current Adapter)

The default repository is in-memory only. For production, add durable adapters and backup controls in the infrastructure layer while keeping existing application and domain contracts unchanged.
