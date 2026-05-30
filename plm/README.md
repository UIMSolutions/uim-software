# Product Lifecycle Management Service

<!-- markdownlint-disable MD040 MD060 MD047 -->

A vibe.d microservice in D that models a cloud-native Product Lifecycle Management capability set inspired by SAP S/4HANA Product Lifecycle Management. The service follows a combination of clean architecture and hexagonal architecture so the domain remains independent from HTTP, persistence, and deployment concerns.

The solution focuses on product lifecycle control from definition through release, including product master data, bills of material, engineering change requests, document handling, specifications, recipe or formulation management, collaboration, and product structure governance.

## Scope

- Product master and lifecycle status management
- Engineering and manufacturing bill of material handling
- Engineering change request tracking and approval support
- Product document and attachment cataloguing
- Specification and compliance definition
- Recipe or formulation management for process-oriented products
- Cross-functional collaboration and review tasks
- Product structure and hierarchy management

## Architecture

```
source/
  uim/platform/plm/
    domain/           # Entities, repository interfaces, domain services
    application/      # DTOs and use cases
    infrastructure/   # Configuration and composition root
    presentation/     # HTTP adapters and JSON helpers
```

### Clean Architecture

- **Domain** contains product lifecycle entities and business rules.
- **Application** orchestrates lifecycle use cases and translates DTOs into domain operations.
- **Infrastructure** wires repositories, configuration, and controller instances.
- **Presentation** exposes REST endpoints and serializes responses.

### Hexagonal Architecture

- **Ports** are repository interfaces and application use cases.
- **Adapters** are vibe.d controllers, JSON helpers, and in-memory repositories.

## Planned Capability Areas

- Product management
- BOM management
- Change management
- Document management
- Specification management
- Recipe management
- Collaboration management
- Product structure management

## Initial HTTP Surface

| Method | Path | Description |
|--------|------|-------------|
| GET | `/` | Service status message |
| GET | `/health` | Health check |
| GET | `/api/v1/plm/products` | List products |
| POST | `/api/v1/plm/products` | Create a product |
| GET | `/api/v1/plm/products/:id` | Get product by ID |
| PUT | `/api/v1/plm/products/:id` | Update product |
| DELETE | `/api/v1/plm/products/:id` | Delete product |
| GET | `/api/v1/plm/boms` | List bills of material |
| POST | `/api/v1/plm/boms` | Create a BOM |
| GET | `/api/v1/plm/change-requests` | List change requests |
| POST | `/api/v1/plm/change-requests` | Create a change request |
| GET | `/api/v1/plm/documents` | List documents |
| POST | `/api/v1/plm/documents` | Create a document |
| GET | `/api/v1/plm/specifications` | List specifications |
| POST | `/api/v1/plm/specifications` | Create a specification |
| GET | `/api/v1/plm/recipes` | List recipes |
| POST | `/api/v1/plm/recipes` | Create a recipe |
| GET | `/api/v1/plm/collaborations` | List collaborations |
| POST | `/api/v1/plm/collaborations` | Create a collaboration |
| GET | `/api/v1/plm/product-structures` | List product structures |
| POST | `/api/v1/plm/product-structures` | Create a product structure |
| GET | `/api/v1/health` | Global health check |

All state-changing endpoints should use `X-Tenant-Id` for tenant isolation.

## Configuration

| Environment Variable | Default | Description |
|----------------------|---------|-------------|
| `PLM_HOST` | `0.0.0.0` | HTTP bind address |
| `PLM_PORT` | `8131` | HTTP listen port |

## Build and Run

```bash
# Build
dub build

# Run
dub run

# Test
dub test
```

## Reference

Based on the SAP Help Portal description for SAP S/4HANA Product Lifecycle Management.
