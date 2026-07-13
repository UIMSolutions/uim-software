module uim.platform.maif.domain.entities.integration_flow;

@safe:

struct IntegrationFlow {
    string id;
    string tenantId;
    string appId;
    string name;
    string sourceSystem;
    string targetSystem;
    string protocol;
    string mappingPolicy;
    string retryPolicy;
    string status;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
