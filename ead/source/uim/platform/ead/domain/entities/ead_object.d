module uim.platform.ead.domain.entities.ead_object;

@safe:

enum EadBusinessObjectType : string {
    businessCapabilities = "business-capabilities",
    valueStreams = "value-streams",
    businessProcesses = "business-processes",
    processSteps = "process-steps",
    businessServices = "business-services",
    organizationUnits = "organization-units",
    roles = "roles",
    informationObjects = "information-objects",
    dataObjects = "data-objects",
    applicationComponents = "application-components",
    applicationServices = "application-services",
    interfaces = "interfaces",
    apiDefinitions = "api-definitions",
    integrationFlows = "integration-flows",
    technologyComponents = "technology-components",
    technologyServices = "technology-services",
    systems = "systems",
    landscapes = "landscapes",
    standards = "standards",
    principles = "principles",
    viewpoints = "viewpoints",
    diagrams = "diagrams",
    dependencies = "dependencies",
    roadmaps = "roadmaps",
    workPackages = "work-packages",
    projects = "projects",
    risks = "risks",
    controls = "controls",
    auditEntries = "audit-entries"
}

struct EadObject {
    string id;
    string objectType;
    string tenantId;
    string technicalName;
    string businessName;
    string architectureLayer;
    string lifecycleState;
    string parentId;
    string sourceId;
    string targetId;
    string owner;
    string description;
    string externalReference;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
    string[string] metadata;
}
