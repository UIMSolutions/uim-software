module uim.platform.team.domain.repositories.document_repository;

import uim.platform.team.domain;

@safe:

interface DocumentRepository {
    Document[] findAll();
    Document[] findByTenant(TenantId tenantId);
    Document* findById(DocumentId id);
    Document[] findByPart(PartId partId);
    Document[] findByChange(ChangeId changeId);
    void save(Document document);
    void update(Document document);
    void remove(DocumentId id);
}
