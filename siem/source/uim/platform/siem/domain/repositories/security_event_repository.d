/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.siem.domain.repositories.security_event_repository;

import uim.platform.siem;

mixin(ShowModule!());

@safe:

interface SecurityEventRepository {
    SecurityEvent[] findAll();
    SecurityEvent* findById(SecurityEventId id);
    SecurityEvent[] findByTenant(TenantId tenantId);
    SecurityEvent[] findBySeverity(EventSeverity severity);
    SecurityEvent[] findByStatus(EventStatus status);
    SecurityEvent[] findByAsset(AssetId assetId);
    void save(SecurityEvent event);
    void update(SecurityEvent event);
    void remove(SecurityEventId id);
}
