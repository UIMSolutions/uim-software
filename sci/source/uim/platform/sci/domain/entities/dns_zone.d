/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.sci.domain.entities.dns_zone;

import uim.platform.sci;

mixin(ShowModule!());

@safe:

struct DnsZone {
    DnsZoneId id;
    TenantId tenantId;
    string name;
    string description;
    DnsZoneStatus status = DnsZoneStatus.active;
    DnsZoneType zoneType = DnsZoneType.primary;
    string email;
    string ttl;
    string serial;
    DnsRecordType recordType = DnsRecordType.a;
    string recordName;
    string recordData;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
