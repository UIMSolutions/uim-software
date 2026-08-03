module uim.platform.material_traceability.domain.entities.mt_object;

@safe:

enum MtBusinessObjectType : string {
    materials = "materials",
    materialLots = "material-lots",
    batches = "batches",
    serialNumbers = "serial-numbers",
    suppliers = "suppliers",
    manufacturers = "manufacturers",
    plants = "plants",
    warehouses = "warehouses",
    shipmentUnits = "shipment-units",
    transportEvents = "transport-events",
    transformationEvents = "transformation-events",
    consumptionEvents = "consumption-events",
    qualityInspections = "quality-inspections",
    certificates = "certificates",
    complianceStatements = "compliance-statements",
    recallCases = "recall-cases",
    incidents = "incidents",
    chainOfCustodyLinks = "chain-of-custody-links",
    lineageViews = "lineage-views",
    riskAssessments = "risk-assessments",
    partnerMappings = "partner-mappings",
    documentReferences = "document-references",
    apiDefinitions = "api-definitions",
    auditEntries = "audit-entries"
}

struct MtObject {
    string id;
    string objectType;
    string tenantId;
    string technicalName;
    string businessName;
    string traceabilityDomain;
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
