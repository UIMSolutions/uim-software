# NAFv4 Views - Advanced Workflow

## C1 - Capability Taxonomy

```text
Advanced Workflow
├── Workflow Modeling
│   ├── Definition Lifecycle
│   ├── Category and Starter Assignment
│   └── Priority and Status Control
├── Workflow Runtime
│   ├── Instance Startup
│   ├── Business Object Binding
│   └── Runtime State Management
├── Human Task Processing
│   ├── Task Assignment
│   ├── Approval Decisions
│   └── Completion Tracking
├── Deadline and Escalation
│   ├── Deadline Policies
│   ├── Escalation Routing
│   └── Notification Status
├── Substitution Management
│   ├── Delegate Assignment
│   ├── Validity Periods
│   └── Activation Control
└── Context and Events
    ├── Key/Value Runtime Context
    ├── Event Timeline
    └── Operational Observability
```

## C2 - Enterprise Vision

| Aspect | Description |
| --- | --- |
| Mission | Standardize and automate cross-domain approvals |
| Vision | Unified workflow runtime for all enterprise process approvals |
| Strategic goals | Faster cycle time, higher traceability, policy compliance |
| Stakeholders | Process owners, approvers, administrators, audit teams |

## L1 - Node Types

| Node Type | Description |
| --- | --- |
| WorkflowDefinition | Template for runtime workflows |
| WorkflowInstance | Running workflow bound to business object |
| WorkflowTask | User task generated from workflow runtime |
| ApprovalDecision | Decision record attached to task |
| DeadlineEscalation | Escalation policy execution record |
| WorkflowSubstitution | Delegation settings for user absence |
| WorkflowContext | Runtime context key/value data |
| WorkflowEvent | Immutable event record of runtime transitions |

## L2 - Logical Scenarios

| Scenario | Trigger | Flow |
| --- | --- | --- |
| Approval start | Request submitted | Definition lookup -> Instance creation -> Task creation |
| Approval decision | Approver action | Task update -> Decision create -> Event append |
| Deadline breach | Due date reached | Escalation create -> Assignment update -> Event append |
| Delegate execution | User unavailable | Substitution resolution -> Task reassignment |
| Audit reconstruction | Audit request | Query events + decisions + context by instance |

## P2 - Resource Structure

```text
Workflow Service (Port 8148)
├── Presentation Layer
│   ├── WorkflowHealthController
│   ├── WorkflowWebClientController
│   ├── WorkflowDefinitionController
│   ├── WorkflowInstanceController
│   ├── WorkflowTaskController
│   ├── ApprovalDecisionController
│   ├── DeadlineEscalationController
│   ├── WorkflowSubstitutionController
│   ├── WorkflowContextController
│   └── WorkflowEventController
├── Application Layer
│   └── ManageWorkflowDataUseCase
├── Domain Layer
│   ├── 8 business objects
│   ├── repository ports
│   └── WorkflowValidator
└── Infrastructure Layer
    ├── AppConfig
    ├── Container
    └── in-memory repository adapters
```

## S1 - Service Taxonomy

| Service Function Group | Endpoint Family |
| --- | --- |
| Modeling | /api/v1/workflow/definitions |
| Runtime | /api/v1/workflow/instances |
| Task Operations | /api/v1/workflow/tasks |
| Decisions | /api/v1/workflow/decisions |
| Escalations | /api/v1/workflow/deadlines |
| Substitutions | /api/v1/workflow/substitutions |
| Runtime Context | /api/v1/workflow/contexts |
| Event History | /api/v1/workflow/events |
| Health and UI | /health, /api/v1/health, /client |
