module uim.platform.ecc.domain.repositories.change_request_repository;

import uim.platform.ecc.domain.entities.change_request;
import uim.platform.ecc.domain.types;

@safe:

interface ChangeRequestRepository {
    ChangeRequest[] findAll();
    ChangeRequest* findById(ChangeRequestId id);
    void save(ChangeRequest value);
    void update(ChangeRequest value);
    void remove(ChangeRequestId id);
}