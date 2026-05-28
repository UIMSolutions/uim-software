/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.domain.repositories.sla_repository;

import uim.platform.itil;

mixin(ShowModule!());

@safe:

interface SLARepository {
    ServiceLevelAgreement[] findAll();
    ServiceLevelAgreement* findById(ServiceLevelAgreementId id);
    ServiceLevelAgreement[] findByTenant(TenantId tenantId);
    ServiceLevelAgreement[] findByStatus(SLAStatus slaStatus);
    ServiceLevelAgreement[] findByService(ITServiceId serviceId);
    ServiceLevelAgreement[] findByCustomer(string customerId);
    void save(ServiceLevelAgreement sla);
    void update(ServiceLevelAgreement sla);
    void remove(ServiceLevelAgreementId id);
}
