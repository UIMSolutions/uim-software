module uim.platform.plm.domain.repositories.document_repository;

import uim.platform.plm.domain.entities.document;
import uim.platform.plm.domain.types;

@safe:

interface DocumentRepository {
    Document[] findAll();
    Document* findById(DocumentId id);
    void save(Document value);
    void update(Document value);
    void remove(DocumentId id);
}