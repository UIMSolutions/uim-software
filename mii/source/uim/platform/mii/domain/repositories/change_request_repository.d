module uim.platform.mii.domain.repositories.change_request_repository;

import uim.platform.mii.domain.entities.change_request;
import uim.platform.mii.domain.types;

@safe:

interface ChangeRequestRepository {
    ChangeRequest[] findAll();
    ChangeRequest* findById(ChangeRequestId id);
    void save(ChangeRequest value);
    void update(ChangeRequest value);
    void remove(ChangeRequestId id);
}