module uim.platform.ecm.domain.entities.ecm_object;

@safe:

enum BusinessObjectType : string {
    repository = "repositories",
    workspace = "workspaces",
    folder = "folders",
    document = "documents",
    documentVersion = "document-versions",
    metadataCategory = "metadata-categories",
    user = "users",
    group = "groups",
    permission = "permissions",
    record = "records",
    retentionPolicy = "retention-policies",
    workflow = "workflows",
    auditEntry = "audit-entries"
}

struct EcmObject {
    string id;
    string objectType;
    string tenantId;
    string name;
    string title;
    string status;
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
