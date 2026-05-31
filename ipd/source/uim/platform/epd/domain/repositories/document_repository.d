module uim.platform.epd.domain.repositories.document_repository;

import uim.platform.epd.domain.entities.document;
import uim.platform.epd.domain.types;

@safe:

interface DocumentRepository {
    Document[] findAll();
    Document* findById(DocumentId id);
    void save(Document value);
    void update(Document value);
    void remove(DocumentId id);
}