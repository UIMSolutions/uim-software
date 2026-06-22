module uim.platform.team.domain.repositories.change_request_repository;

import uim.platform.team.domain;

@safe:

interface ChangeRequestRepository {
    ChangeRequest[] findAll();
    ChangeRequest[] findByTenant(TenantId tenantId);
    ChangeRequest* findById(ChangeId id);
    ChangeRequest[] findByPart(PartId partId);
    void save(ChangeRequest changeRequest);
    void update(ChangeRequest changeRequest);
    void remove(ChangeId id);
}
