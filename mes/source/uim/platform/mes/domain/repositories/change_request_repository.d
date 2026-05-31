module uim.platform.mes.domain.repositories.change_request_repository;

import uim.platform.mes.domain.entities.change_request;
import uim.platform.mes.domain.types;

@safe:

interface ChangeRequestRepository {
    ChangeRequest[] findAll();
    ChangeRequest* findById(ChangeRequestId id);
    void save(ChangeRequest value);
    void update(ChangeRequest value);
    void remove(ChangeRequestId id);
}