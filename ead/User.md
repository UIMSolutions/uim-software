# User Guide

## Quick Start

1. Open the UI at /ui.
2. Create architecture objects via API endpoints.
3. Link architecture elements with dependencies.
4. Run search and impact analysis APIs.
5. Render diagram snapshots using /api/v1/ead/diagram-renderings.

## Example API Flow

Create an application component:

```http
POST /api/v1/ead/application-components
Authorization: Bearer demo
X-EAD-Roles: ead.admin
Content-Type: application/json

{
  "technicalName": "APP_S4",
  "businessName": "SAP S/4HANA",
  "architectureLayer": "application"
}
```

Create a dependency:

```http
POST /api/v1/ead/dependencies
Authorization: Bearer demo
X-EAD-Roles: ead.admin
Content-Type: application/json

{
  "technicalName": "IFLOW_S4_BTP",
  "sourceId": "<APP_S4_ID>",
  "targetId": "<APP_BTP_ID>",
  "architectureLayer": "integration"
}
```

Query dependencies by source:

```http
GET /api/v1/ead/dependencies/by-source/<APP_S4_ID>
Authorization: Bearer demo
```
