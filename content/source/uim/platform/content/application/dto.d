module uim.platform.content.application.dto;

@safe:

struct CommandResult {
    bool success;
    string id;
    string error;
}

struct ContentRepositoryDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string storageType;
    string basePath;
    string status;
    string createdBy;
    string modifiedBy;
}

struct FolderDTO {
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
}

struct DocumentDTO {
    string id;
    string tenantId;
    string repositoryId;
    string folderId;
    string title;
    string documentNumber;
    string objectType;
    string mimeType;
    string fileName;
    string fileSize;
    string checksum;
    string storageUri;
    string status;
    string classification;
    string tags;
    string createdBy;
    string modifiedBy;
}

struct DocumentVersionDTO {
    string id;
    string tenantId;
    string documentId;
    string versionLabel;
    string fileName;
    string mimeType;
    string fileSize;
    string checksum;
    string storageUri;
    string versionNote;
    string createdBy;
}
