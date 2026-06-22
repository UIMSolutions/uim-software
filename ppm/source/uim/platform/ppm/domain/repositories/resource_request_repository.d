module uim.platform.ppm.domain.repositories.resource_request_repository;

import uim.platform.ppm.domain.entities.resource_request;
import uim.platform.ppm.domain.types;

@safe:

interface ResourceRequestRepository {
    ResourceRequest[] findAll();
    ResourceRequest* findById(ResourceRequestId id);
    void save(ResourceRequest value);
    void update(ResourceRequest value);
    void remove(ResourceRequestId id);
}
