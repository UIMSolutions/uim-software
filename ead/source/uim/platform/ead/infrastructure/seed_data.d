module uim.platform.ead.infrastructure.seed_data;

import std.datetime : Clock;
import uim.platform.ead.domain.entities.ead_object : EadObject, EadBusinessObjectType;
import uim.platform.ead.domain.repositories.ead_repository : EadRepository;

@safe:

void seedDefaultEadData(EadRepository repository) {
    if (repository.listByType(EadBusinessObjectType.applicationComponents).length > 0) {
        return;
    }

    auto now = Clock.currTime().toISOExtString();

    repository.create(makeObj(
        "CAP-001",
        EadBusinessObjectType.businessCapabilities,
        "CAP_ORDER_TO_CASH",
        "Order to Cash",
        "business",
        now
    ));

    repository.create(makeObj(
        "PRC-001",
        EadBusinessObjectType.businessProcesses,
        "PROC_ORDER_FULFILLMENT",
        "Order Fulfillment",
        "business",
        now,
        "CAP-001"
    ));

    repository.create(makeObj(
        "APP-001",
        EadBusinessObjectType.applicationComponents,
        "APP_S4",
        "SAP S/4HANA",
        "application",
        now
    ));

    repository.create(makeObj(
        "APP-002",
        EadBusinessObjectType.applicationComponents,
        "APP_BTP_INT",
        "SAP BTP Integration Suite",
        "application",
        now
    ));

    repository.create(makeObj(
        "APP-003",
        EadBusinessObjectType.applicationComponents,
        "APP_SAC",
        "SAP Analytics Cloud",
        "application",
        now
    ));

    repository.create(makeObj(
        "SVC-001",
        EadBusinessObjectType.applicationServices,
        "SVC_SALES_ORDER_API",
        "Sales Order API",
        "application",
        now,
        "APP-001"
    ));

    repository.create(makeObj(
        "API-001",
        EadBusinessObjectType.apiDefinitions,
        "API_SALES_ORDER_O4",
        "Sales Order OData API",
        "integration",
        now,
        "SVC-001"
    ));

    repository.create(makeDependency(
        "DEP-001",
        "IFLOW_S4_TO_BTP",
        "S4 to BTP integration flow",
        "APP-001",
        "APP-002",
        now
    ));

    repository.create(makeDependency(
        "DEP-002",
        "IFLOW_BTP_TO_SAC",
        "BTP to SAC replication",
        "APP-002",
        "APP-003",
        now
    ));

    repository.create(makeObj(
        "VWP-001",
        EadBusinessObjectType.viewpoints,
        "VIEW_LANDSCAPE",
        "Landscape View",
        "technology",
        now
    ));

    repository.create(makeObj(
        "DGM-001",
        EadBusinessObjectType.diagrams,
        "DIA_OTC_L1",
        "Order to Cash Landscape",
        "application",
        now,
        "VWP-001"
    ));

    repository.create(makeObj(
        "TEC-001",
        EadBusinessObjectType.technologyComponents,
        "TECH_K8S",
        "Kubernetes Platform",
        "technology",
        now
    ));

    repository.create(makeObj(
        "STD-001",
        EadBusinessObjectType.standards,
        "STD_EVENT_DRIVEN",
        "Event-Driven Integration Standard",
        "technology",
        now
    ));

    repository.create(makeObj(
        "RSK-001",
        EadBusinessObjectType.risks,
        "RISK_POINT_TO_POINT",
        "Point-to-point integration risk",
        "governance",
        now
    ));
}

private EadObject makeObj(
    string id,
    string objectType,
    string technicalName,
    string businessName,
    string architectureLayer,
    string now,
    string parentId = ""
) {
    EadObject value;
    value.id = id;
    value.objectType = objectType;
    value.tenantId = "default";
    value.technicalName = technicalName;
    value.businessName = businessName;
    value.architectureLayer = architectureLayer;
    value.lifecycleState = "active";
    value.parentId = parentId;
    value.owner = "ead-seeder";
    value.description = businessName;
    value.createdBy = "seed";
    value.modifiedBy = "seed";
    value.createdAt = now;
    value.modifiedAt = now;
    return value;
}

private EadObject makeDependency(
    string id,
    string technicalName,
    string description,
    string sourceId,
    string targetId,
    string now
) {
    EadObject value = makeObj(
        id,
        EadBusinessObjectType.dependencies,
        technicalName,
        technicalName,
        "integration",
        now
    );
    value.description = description;
    value.sourceId = sourceId;
    value.targetId = targetId;
    return value;
}
