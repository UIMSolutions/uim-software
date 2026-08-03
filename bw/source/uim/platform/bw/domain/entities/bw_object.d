module uim.platform.bw.domain.entities.bw_object;

@safe:

enum BwBusinessObjectType : string {
    infoAreas = "info-areas",
    infoObjects = "info-objects",
    characteristics = "characteristics",
    keyFigures = "key-figures",
    hierarchies = "hierarchies",
    dataSources = "data-sources",
    transformations = "transformations",
    dtrs = "data-transfer-processes",
    adsos = "adsos",
    openHubDestinations = "open-hub-destinations",
    compositeProviders = "composite-providers",
    cubes = "cubes",
    multiProviders = "multi-providers",
    queries = "queries",
    workbooks = "workbooks",
    processChains = "process-chains",
    analysisAuthorizations = "analysis-authorizations",
    planningModels = "planning-models",
    aggregationLevels = "aggregation-levels",
    planningFunctions = "planning-functions",
    dataSlices = "data-slices",
    dataFlows = "data-flows",
    apiDefinitions = "api-definitions",
    auditEntries = "audit-entries"
}

struct BwObject {
    string id;
    string objectType;
    string tenantId;
    string technicalName;
    string businessName;
    string semanticLayer;
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
