/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.siem.domain.repositories.threat_indicator_repository;

import uim.platform.siem;

mixin(ShowModule!());

@safe:

interface ThreatIndicatorRepository {
    ThreatIndicator[] findAll();
    ThreatIndicator* findById(ThreatIndicatorId id);
    ThreatIndicator[] findByTenant(TenantId tenantId);
    ThreatIndicator[] findByType(ThreatIndicatorType indicatorType);
    ThreatIndicator[] findByConfidence(ThreatIndicatorConfidence confidence);
    void save(ThreatIndicator indicator);
    void update(ThreatIndicator indicator);
    void remove(ThreatIndicatorId id);
}
