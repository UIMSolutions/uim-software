module uim.platform.ecc.domain.repositories.document_repository;

import uim.platform.ecc.domain.entities.document;
import uim.platform.ecc.domain.types;

@safe:

interface DocumentRepository {
    Document[] findAll();
    Document* findById(DocumentId id);
    void save(Document value);
    void update(Document value);
    void remove(DocumentId id);
}