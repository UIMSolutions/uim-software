/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.domain.repositories.service_request_repository;

import uim.platform.itil;

mixin(ShowModule!());

@safe:

interface ServiceRequestRepository {
    ServiceRequest[] findAll();
    ServiceRequest* findById(ServiceRequestId id);
    ServiceRequest[] findByTenant(TenantId tenantId);
    ServiceRequest[] findByStatus(RecordStatus status);
    ServiceRequest[] findByPriority(Priority priority);
    ServiceRequest[] findByService(ITServiceId serviceId);
    ServiceRequest[] findByRequester(string requesterId);
    void save(ServiceRequest request);
    void update(ServiceRequest request);
    void remove(ServiceRequestId id);
}
