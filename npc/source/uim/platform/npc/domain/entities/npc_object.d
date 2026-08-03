module uim.platform.npc.domain.entities.npc_object;

@safe:

enum NpcBusinessObjectType : string {
    organizations = "organizations",
    suppliers = "suppliers",
    customers = "customers",
    products = "products",
    locations = "locations",
    resources = "resources",
    capacities = "capacities",
    demandPlans = "demand-plans",
    supplyPlans = "supply-plans",
    constrainedPlans = "constrained-plans",
    scenarios = "scenarios",
    assumptions = "assumptions",
    milestones = "milestones",
    exceptions = "exceptions",
    alerts = "alerts",
    commitments = "commitments",
    allocations = "allocations",
    collaborationThreads = "collaboration-threads",
    comments = "comments",
    attachments = "attachments",
    workflows = "workflows",
    approvals = "approvals",
    kpiDefinitions = "kpi-definitions",
    kpiValues = "kpi-values",
    apiDefinitions = "api-definitions",
    auditEntries = "audit-entries"
}

struct NpcObject {
    string id;
    string objectType;
    string tenantId;
    string technicalName;
    string businessName;
    string planningDomain;
    string sourceSystem;
    string lifecycleState;
    string parentId;
    string owner;
    string description;
    string externalReference;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
    string[string] metadata;
}
