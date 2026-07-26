# UIM ALM Service

Solution lifecycle and operations service built with D and vibe.d using clean architecture and hexagonal architecture patterns. The service is modeled after the main problem areas in SAP Cloud ALM: solution governance, delivery tracking, test management, release orchestration, and operations insight.

## Scope

This scaffold covers the common CALM-style business objects needed to run a solution lifecycle service:

1. Solutions and their lifecycle stage.
2. Projects and tasks for implementation tracking.
3. Test plans, test cases, and defects.
4. Releases, deployments, environments, and alerts.
5. Portfolio summary and readiness reporting.

## Business Objects

- Solution
- Project
- Task
- TestPlan
- TestCase
- Defect
- Release
- Deployment
- Environment
- Alert

## API Endpoints

| Method | Path | Purpose |
|--------|------|---------|
| GET | `/` | Root service info |
| GET | `/health` | Health |
| GET | `/api/v1/health` | Health |
| GET/POST | `/api/v1/alm/solutions` | List/create solutions |
| GET/PUT/DELETE | `/api/v1/alm/solutions/*` | Read/update/delete solution |
| GET/POST | `/api/v1/alm/projects` | List/create projects |
| GET/PUT/DELETE | `/api/v1/alm/projects/*` | Read/update/delete project |
| GET/POST | `/api/v1/alm/tasks` | List/create tasks |
| GET/PUT/DELETE | `/api/v1/alm/tasks/*` | Read/update/delete task |
| GET/POST | `/api/v1/alm/test-plans` | List/create test plans |
| GET/PUT/DELETE | `/api/v1/alm/test-plans/*` | Read/update/delete test plan |
| GET/POST | `/api/v1/alm/test-cases` | List/create test cases |
| GET/PUT/DELETE | `/api/v1/alm/test-cases/*` | Read/update/delete test case |
| GET/POST | `/api/v1/alm/defects` | List/create defects |
| GET/PUT/DELETE | `/api/v1/alm/defects/*` | Read/update/delete defect |
| GET/POST | `/api/v1/alm/releases` | List/create releases |
| GET/PUT/DELETE | `/api/v1/alm/releases/*` | Read/update/delete release |
| GET/POST | `/api/v1/alm/deployments` | List/create deployments |
| GET/PUT/DELETE | `/api/v1/alm/deployments/*` | Read/update/delete deployment |
| GET/POST | `/api/v1/alm/environments` | List/create environments |
| GET/PUT/DELETE | `/api/v1/alm/environments/*` | Read/update/delete environment |
| GET/POST | `/api/v1/alm/alerts` | List/create alerts |
| GET/PUT/DELETE | `/api/v1/alm/alerts/*` | Read/update/delete alert |
| GET | `/api/v1/alm/summary` | Portfolio summary |

## Architecture

```text
source/
  app.d
  uim/platform/alm/
    domain/
      types.d
      entities.d
      repositories.d
      services.d
    application/
      dto.d
      usecases.d
    infrastructure/
      config.d
      container.d
      persistence/memory.d
    presentation/
      http/
        json_utils.d
        controllers.d
```

## Build and Run

```bash
cd alm
dub test
dub run
```

## Configuration

| Variable | Default | Description |
|----------|---------|-------------|
| `ALM_HOST` | `0.0.0.0` | HTTP bind host |
| `ALM_PORT` | `8160` | HTTP bind port |
