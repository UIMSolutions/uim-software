module uim.platform.content.domain.entities.content_repository;

@safe:

struct ContentRepository {
    string id;
    string tenantId;
    string name;
    string description;
    string storageType;
    string basePath;
    string status;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
