# User Guide

## Overview

This service supports workflow orchestration similar to SAP Advanced Workflow concepts.

Core usage flow:

1. Create a workflow definition.
2. Start an instance referencing a business object.
3. Create tasks for approvers.
4. Record decisions.
5. Handle deadline escalations and substitutions.
6. Track context and event history.

## Quick Start

1. Open web client: `/client`
2. Create a definition.
3. List definitions.

## API Usage Examples

### Create Definition

```http
POST /api/v1/workflow/definitions
X-Tenant-Id: TEN-1
Content-Type: application/json

{
  "id": "WF-DEF-001",
  "name": "Purchase Request Approval",
  "category": "Procurement",
  "starterRole": "Requester",
  "priority": "high",
  "status": "active",
  "createdBy": "admin"
}
```

### Create Instance

```http
POST /api/v1/workflow/instances
X-Tenant-Id: TEN-1
Content-Type: application/json

{
  "id": "WF-INS-001",
  "definitionId": "WF-DEF-001",
  "businessObjectType": "PurchaseRequest",
  "businessObjectId": "PR-93211",
  "status": "active",
  "startedBy": "alice",
  "startedAt": "2026-07-26T12:00:00Z"
}
```

### Create Task

```http
POST /api/v1/workflow/tasks
X-Tenant-Id: TEN-1
Content-Type: application/json

{
  "id": "WF-TASK-001",
  "instanceId": "WF-INS-001",
  "title": "Approve Request",
  "assignee": "manager",
  "priority": "normal",
  "state": "ready"
}
```

### Create Decision

```http
POST /api/v1/workflow/decisions
X-Tenant-Id: TEN-1
Content-Type: application/json

{
  "id": "WF-DEC-001",
  "taskId": "WF-TASK-001",
  "decision": "approve",
  "comment": "Approved",
  "decidedBy": "manager",
  "decidedAt": "2026-07-26T12:10:00Z"
}
```
