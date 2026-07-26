# NAFv4 - UIM ALM Service

## Goal

Provide a CALM-style solution lifecycle service for planning, delivery, test, release, deployment, and operations visibility.

## Active Structure

| Layer | Content |
|-------|---------|
| Presentation | vibe.d HTTP controllers for solutions, delivery, quality, operations, and summary |
| Application | Use cases that coordinate CRUD flows and portfolio reporting |
| Domain | CALM-style entities, lifecycle enums, and policy rules |
| Infrastructure | In-memory repository adapters and application container wiring |

## Business Objects

| Object | Description |
|--------|-------------|
| Solution | Business solution or scope unit under lifecycle governance |
| Project | Delivery initiative linked to a solution |
| Task | Delivery work item under a project or solution |
| TestPlan | Test scope and execution container |
| TestCase | Individual test specification and result state |
| Defect | Problem discovered in a test or delivery cycle |
| Release | Planned or shipped solution release |
| Deployment | Environment-specific rollout event |
| Environment | Target system landscape entry |
| Alert | Operations signal from monitoring or support |

## Interfaces

| Interface | Responsibility |
|-----------|----------------|
| HTTP API | CRUD over the business objects plus summary reporting |
| Repository Ports | Persist and query aggregate state |
| Lifecycle Policy | Normalize and validate stage transitions |
