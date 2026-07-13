module uim.platform.content.domain.entities.folder;

@safe:

struct Folder {
    string id;
    string tenantId;
    string repositoryId;
    string parentFolderId;
    string name;
    string path;
    string description;
    string status;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
