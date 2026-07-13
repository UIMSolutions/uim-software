module uim.platform.content.domain.repositories.document_version_repository;

import uim.platform.content.domain.entities.document_version;

@safe:

interface DocumentVersionRepository {
    DocumentVersion[] listByDocumentId(string documentId);
    const(DocumentVersion)* get_(string id);
    bool create(DocumentVersion value);
    bool update(DocumentVersion value);
    bool remove(string id);
}
