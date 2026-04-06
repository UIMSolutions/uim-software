/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.sci.infrastructure.persistence.memory.dns_zones;

import uim.platform.sci;

mixin(ShowModule!());

@safe:

class MemoryDnsZoneRepository : DnsZoneRepository {
    private DnsZone[] store;

    DnsZone[] findAll() { return store; }

    DnsZone* findById(DnsZoneId id) {
        foreach (ref e; store)
            if (e.id == id) return &e;
        return null;
    }

    DnsZone[] findByTenant(TenantId tenantId) {
        DnsZone[] result;
        foreach (ref e; store)
            if (e.tenantId == tenantId) result ~= e;
        return result;
    }

    DnsZone[] findByStatus(DnsZoneStatus status) {
        DnsZone[] result;
        foreach (ref e; store)
            if (e.status == status) result ~= e;
        return result;
    }

    DnsZone[] findByZoneType(DnsZoneType zoneType) {
        DnsZone[] result;
        foreach (ref e; store)
            if (e.zoneType == zoneType) result ~= e;
        return result;
    }

    void save(DnsZone dnsZone) { store ~= dnsZone; }

    void update(DnsZone dnsZone) {
        foreach (ref e; store)
            if (e.id == dnsZone.id) { e = dnsZone; return; }
    }

    void remove(DnsZoneId id) {
        import std.algorithm : remove;
        store = store.remove!(e => e.id == id);
    }
}
