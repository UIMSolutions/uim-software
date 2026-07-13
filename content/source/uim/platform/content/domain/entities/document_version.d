module uim.platform.content.domain.entities.document_version;

@safe:

struct DocumentVersion {
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
    string createdAt;
}
