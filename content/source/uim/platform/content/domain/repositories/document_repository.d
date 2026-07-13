module uim.platform.content.domain.repositories.document_repository;

import uim.platform.content.domain.entities.document;

@safe:

interface DocumentRepository {
    Document[] list();
    const(Document)* get_(string id);
    bool create(Document value);
    bool update(Document value);
    bool remove(string id);
}
