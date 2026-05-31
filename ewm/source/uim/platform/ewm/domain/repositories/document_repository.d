module uim.platform.ewm.domain.repositories.document_repository;

import uim.platform.ewm.domain.entities.document;
import uim.platform.ewm.domain.types;

@safe:

interface DocumentRepository {
    Document[] findAll();
    Document* findById(DocumentId id);
    void save(Document value);
    void update(Document value);
    void remove(DocumentId id);
}