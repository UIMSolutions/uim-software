/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.infrastructure.persistence.repositories.service_requests;

import uim.platform.itil;
import std.algorithm : filter;
import std.array : array;

mixin(ShowModule!());

@safe:

class MemoryServiceRequestRepository : ServiceRequestRepository {
    private ServiceRequest[] store;

    ServiceRequest[] findAll() { return store.dup; }

    ServiceRequest* findById(ServiceRequestId id) {
        foreach (ref s; store) if (s.id == id) return &s;
        return null;
    }

    ServiceRequest[] findByTenant(TenantId tenantId) {
        return store.filter!(s => s.tenantId == tenantId).array;
    }

    ServiceRequest[] findByStatus(RecordStatus status) {
        return store.filter!(s => s.status == status).array;
    }

    ServiceRequest[] findByPriority(Priority priority) {
        return store.filter!(s => s.priority == priority).array;
    }

    ServiceRequest[] findByService(ITServiceId serviceId) {
        return store.filter!(s => s.serviceId == serviceId).array;
    }

    void save(ServiceRequest s) { store ~= s; }

    void update(ServiceRequest s) {
        foreach (ref item; store) {
            if (item.id == s.id) { item = s; return; }
        }
    }

    void remove(ServiceRequestId id) {
        store = store.filter!(s => s.id != id).array;
    }
}
