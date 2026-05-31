module uim.platform.epd.domain.repositories.change_request_repository;

import uim.platform.epd.domain.entities.change_request;
import uim.platform.epd.domain.types;

@safe:

interface ChangeRequestRepository {
    ChangeRequest[] findAll();
    ChangeRequest* findById(ChangeRequestId id);
    void save(ChangeRequest value);
    void update(ChangeRequest value);
    void remove(ChangeRequestId id);
}