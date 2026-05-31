module uim.platform.mes.domain.repositories.document_repository;

import uim.platform.mes.domain.entities.document;
import uim.platform.mes.domain.types;

@safe:

interface DocumentRepository {
    Document[] findAll();
    Document* findById(DocumentId id);
    void save(Document value);
    void update(Document value);
    void remove(DocumentId id);
}