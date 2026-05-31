module uim.platform.ibp.domain.repositories.change_request_repository;

import uim.platform.ibp.domain.entities.change_request;
import uim.platform.ibp.domain.types;

@safe:

interface ChangeRequestRepository {
    ChangeRequest[] findAll();
    ChangeRequest* findById(ChangeRequestId id);
    void save(ChangeRequest value);
    void update(ChangeRequest value);
    void remove(ChangeRequestId id);
}