// Seed catalog data for bw_objects.
// This script is idempotent through upsert operations.

const seedDocs = [
  {
    id: "IA-SALES",
    objectType: "info-areas",
    tenantId: "default",
    technicalName: "ZIA_SALES",
    businessName: "Sales Info Area",
    semanticLayer: "Metadata",
    sourceSystem: "BW",
    lifecycleState: "active",
    parentId: "",
    owner: "dwh.team",
    description: "Top-level sales area",
    externalReference: "sap-bw://info-area/ZIA_SALES",
    createdBy: "seed",
    modifiedBy: "seed",
    createdAt: new Date().toISOString(),
    modifiedAt: new Date().toISOString(),
    metadata: { domain: "sales", criticality: "high" }
  },
  {
    id: "IO-CUSTOMER",
    objectType: "info-objects",
    tenantId: "default",
    technicalName: "0CUSTOMER",
    businessName: "Customer",
    semanticLayer: "Master Data",
    sourceSystem: "S4H",
    lifecycleState: "active",
    parentId: "IA-SALES",
    owner: "dwh.team",
    description: "Customer master object",
    externalReference: "sap-bw://info-object/0CUSTOMER",
    createdBy: "seed",
    modifiedBy: "seed",
    createdAt: new Date().toISOString(),
    modifiedAt: new Date().toISOString(),
    metadata: { kind: "characteristic" }
  },
  {
    id: "ADSO-SALES",
    objectType: "adsos",
    tenantId: "default",
    technicalName: "ZADSO_SALES",
    businessName: "Sales ADSO",
    semanticLayer: "Storage",
    sourceSystem: "BW",
    lifecycleState: "active",
    parentId: "",
    owner: "dwh.team",
    description: "Persistent sales data object",
    externalReference: "sap-bw://adso/ZADSO_SALES",
    createdBy: "seed",
    modifiedBy: "seed",
    createdAt: new Date().toISOString(),
    modifiedAt: new Date().toISOString(),
    metadata: { type: "standard" }
  },
  {
    id: "CP-SALES",
    objectType: "composite-providers",
    tenantId: "default",
    technicalName: "ZCP_SALES",
    businessName: "Sales Composite Provider",
    semanticLayer: "Virtual Model",
    sourceSystem: "BW",
    lifecycleState: "active",
    parentId: "ADSO-SALES",
    owner: "analytics.team",
    description: "Virtual provider for sales analytics",
    externalReference: "sap-bw://composite-provider/ZCP_SALES",
    createdBy: "seed",
    modifiedBy: "seed",
    createdAt: new Date().toISOString(),
    modifiedAt: new Date().toISOString(),
    metadata: { federation: "enabled" }
  },
  {
    id: "Q-SALES-MARGIN",
    objectType: "queries",
    tenantId: "default",
    technicalName: "ZQ_SALES_MARGIN",
    businessName: "Sales Margin Query",
    semanticLayer: "Consumption",
    sourceSystem: "BW",
    lifecycleState: "active",
    parentId: "CP-SALES",
    owner: "analytics.team",
    description: "Query for margin reporting",
    externalReference: "sap-bw://query/ZQ_SALES_MARGIN",
    createdBy: "seed",
    modifiedBy: "seed",
    createdAt: new Date().toISOString(),
    modifiedAt: new Date().toISOString(),
    metadata: { currency: "EUR", refresh: "hourly" }
  },
  {
    id: "DF-SALES-PIPE",
    objectType: "data-flows",
    tenantId: "default",
    technicalName: "ZDF_SALES_PIPE",
    businessName: "Sales Pipeline Flow",
    semanticLayer: "Orchestration",
    sourceSystem: "BW",
    lifecycleState: "active",
    parentId: "DS-BILLING",
    owner: "integration.team",
    description: "Data flow from source extraction to query model",
    externalReference: "sap-bw://data-flow/ZDF_SALES_PIPE",
    createdBy: "seed",
    modifiedBy: "seed",
    createdAt: new Date().toISOString(),
    modifiedAt: new Date().toISOString(),
    metadata: { stages: "extract,transform,load,serve" }
  },
  {
    id: "API-Q-EXEC",
    objectType: "api-definitions",
    tenantId: "default",
    technicalName: "BW_QUERY_EXEC",
    businessName: "Query Execution API",
    semanticLayer: "API",
    sourceSystem: "BDC",
    lifecycleState: "active",
    parentId: "",
    owner: "platform.team",
    description: "Endpoint contract for query execution",
    externalReference: "https://api.example/bw/query-executions",
    createdBy: "seed",
    modifiedBy: "seed",
    createdAt: new Date().toISOString(),
    modifiedAt: new Date().toISOString(),
    metadata: { method: "POST", path: "/api/v1/bw/query-executions" }
  }
];

seedDocs.forEach((doc) => {
  db.bw_objects.updateOne(
    { objectType: doc.objectType, id: doc.id },
    {
      $set: {
        tenantId: doc.tenantId,
        technicalName: doc.technicalName,
        businessName: doc.businessName,
        semanticLayer: doc.semanticLayer,
        sourceSystem: doc.sourceSystem,
        lifecycleState: doc.lifecycleState,
        parentId: doc.parentId,
        owner: doc.owner,
        description: doc.description,
        externalReference: doc.externalReference,
        modifiedBy: "seed",
        modifiedAt: new Date().toISOString(),
        metadata: doc.metadata
      },
      $setOnInsert: {
        createdBy: doc.createdBy,
        createdAt: doc.createdAt
      }
    },
    { upsert: true }
  );
});

print("Seeded bw_objects catalog entries: " + seedDocs.length);
