module uim.platform.content.domain.entities.document;

@safe:

struct Document {
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
    string createdAt;
    string modifiedAt;
}
