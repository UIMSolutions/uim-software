module uim.platform.mii.domain.repositories.document_repository;

import uim.platform.mii.domain.entities.document;
import uim.platform.mii.domain.types;

@safe:

interface DocumentRepository {
    Document[] findAll();
    Document* findById(DocumentId id);
    void save(Document value);
    void update(Document value);
    void remove(DocumentId id);
}