module uim.platform.ibp.domain.repositories.document_repository;

import uim.platform.ibp.domain.entities.document;
import uim.platform.ibp.domain.types;

@safe:

interface DocumentRepository {
    Document[] findAll();
    Document* findById(DocumentId id);
    void save(Document value);
    void update(Document value);
    void remove(DocumentId id);
}