/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.sci.domain.repositories.dns_zone_repository;

import uim.platform.sci;

mixin(ShowModule!());

@safe:

interface DnsZoneRepository {
    DnsZone[] findAll();
    DnsZone* findById(DnsZoneId id);
    DnsZone[] findByTenant(TenantId tenantId);
    DnsZone[] findByStatus(DnsZoneStatus status);
    DnsZone[] findByZoneType(DnsZoneType zoneType);
    void save(DnsZone dnsZone);
    void update(DnsZone dnsZone);
    void remove(DnsZoneId id);
}
