/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.infrastructure.persistence.memory.memory_sla_repository;

import uim.platform.itil;
import std.algorithm : filter;
import std.array : array;

mixin(ShowModule!());

@safe:

class MemorySLARepository : SLARepository {
    private ServiceLevelAgreement[] store;

    ServiceLevelAgreement[] findAll() { return store.dup; }

    ServiceLevelAgreement* findById(ServiceLevelAgreementId id) {
        foreach (ref s; store) if (s.id == id) return &s;
        return null;
    }

    ServiceLevelAgreement[] findByTenant(TenantId tenantId) {
        return store.filter!(s => s.tenantId == tenantId).array;
    }

    ServiceLevelAgreement[] findByStatus(SLAStatus slaStatus) {
        return store.filter!(s => s.slaStatus == slaStatus).array;
    }

    ServiceLevelAgreement[] findByService(ITServiceId serviceId) {
        return store.filter!(s => s.serviceId == serviceId).array;
    }

    ServiceLevelAgreement[] findByCustomer(string customerId) {
        return store.filter!(s => s.customerId == customerId).array;
    }

    void save(ServiceLevelAgreement s) { store ~= s; }

    void update(ServiceLevelAgreement s) {
        foreach (ref item; store) {
            if (item.id == s.id) { item = s; return; }
        }
    }

    void remove(ServiceLevelAgreementId id) {
        store = store.filter!(s => s.id != id).array;
    }
}
