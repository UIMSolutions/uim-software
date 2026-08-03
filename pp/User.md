# User Guide

## Opening the PP UI

1. Start the service with `dub run`.
2. Open `http://localhost:8191/ui`.
3. Select a business object type and create/list entries.

## Create a Material Example

```json
{
  "plantId": "PL01",
  "materialId": "MAT-100",
  "name": "Gear Housing",
  "status": "active",
  "quantity": "250",
  "uom": "EA",
  "priority": "high",
  "createdBy": "planner.a"
}
```

## Execute MRP

`POST /api/v1/pp/mrp-runs/execute`

```json
{
  "plantId": "PL01",
  "materialId": "MAT-100",
  "runMode": "net-change",
  "horizonDays": "14",
  "initiatedBy": "planner.a"
}
```

## Query Planned Orders by Material

`GET /api/v1/pp/planned-orders/by-material/MAT-100`
