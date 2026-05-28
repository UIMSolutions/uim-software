/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.domain.entities.service_level_agreement;

import uim.platform.itil;

mixin(ShowModule!());

@safe:

struct ServiceLevelAgreement {
    ServiceLevelAgreementId id;
    TenantId tenantId;
    string name;
    string description;
    SLAStatus slaStatus = SLAStatus.draft;
    ITServiceId serviceId;
    string customerId;
    string startDate;
    string endDate;
    string availabilityTarget;
    string mttrTarget;
    string responseTimeTarget;
    string resolutionTimeTarget;
    string reviewCycle;
    string accountManager;
    string[] tags;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
