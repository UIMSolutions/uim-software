# SAP Advanced Workflow Inspired Service

A D/vibe.d microservice that models Advanced Workflow style orchestration with Clean Architecture and Hexagonal Architecture.

SAP reference baseline:

<https://help.sap.com/docs/Advanced_Workflow?locale=en-US>

## Business Objects

- WorkflowDefinition
- WorkflowInstance
- WorkflowTask
- ApprovalDecision
- DeadlineEscalation
- WorkflowSubstitution
- WorkflowContext
- WorkflowEvent

## Architecture

```text
source/
  app.d
  uim/platform/workflow/
    domain/
      entities/
      repositories/
      services/
      types.d
    application/
      dto.d
      usecases/manage/
    infrastructure/
      config.d
      container.d
      persistence/memory/
    presentation/
      http/
        controllers/
        json_utils.d
```

## API Endpoints

| Method | Endpoint |
| --- | --- |
| GET/POST/PUT/DELETE | /api/v1/workflow/definitions |
| GET/POST/PUT/DELETE | /api/v1/workflow/instances |
| GET/POST/PUT/DELETE | /api/v1/workflow/tasks |
| GET/POST/PUT/DELETE | /api/v1/workflow/decisions |
| GET/POST/PUT/DELETE | /api/v1/workflow/deadlines |
| GET/POST/PUT/DELETE | /api/v1/workflow/substitutions |
| GET/POST/PUT/DELETE | /api/v1/workflow/contexts |
| GET/POST/PUT/DELETE | /api/v1/workflow/events |
| GET/POST/PUT/DELETE | /api/v1/sap-advanced-workflow/workflow-definitions |
| GET/POST/PUT/DELETE | /api/v1/sap-advanced-workflow/workflow-instances |
| GET/POST/PUT/DELETE | /api/v1/sap-advanced-workflow/workflow-tasks |
| GET/POST/PUT/DELETE | /api/v1/sap-advanced-workflow/approval-decisions |
| GET/POST/PUT/DELETE | /api/v1/sap-advanced-workflow/deadline-escalations |
| GET/POST/PUT/DELETE | /api/v1/sap-advanced-workflow/workflow-substitutions |
| GET/POST/PUT/DELETE | /api/v1/sap-advanced-workflow/workflow-contexts |
| GET/POST/PUT/DELETE | /api/v1/sap-advanced-workflow/workflow-events |
| GET | /api/v1/openapi.yaml |
| GET | /client |
| GET | /health |
| GET | /api/v1/health |

All write calls require tenant context using header `X-Tenant-Id`.

## Configuration

| Variable | Default | Description |
| --- | --- | --- |
| WORKFLOW_HOST | 0.0.0.0 | HTTP bind address |
| WORKFLOW_PORT | 8148 | HTTP listen port |
| WORKFLOW_STORAGE | memory | `memory` or `file` repository adapter |
| WORKFLOW_STORAGE_PATH | .data/workflow | Base path for file-backed persistence |

## Build and Run

```bash
cd workflow
dub build
dub run
dub test
```

## Unit Tests

Unit tests validate:

- definition creation
- task transition update
- decision create/delete lifecycle
- OpenAPI contract paths for standard and SAP-compat routes

## Web Client

Open:

<http://localhost:8148/client>

The web client can create and list workflow definitions over REST.
