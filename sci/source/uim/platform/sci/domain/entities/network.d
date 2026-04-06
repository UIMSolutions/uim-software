/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.sci.domain.entities.network;

import uim.platform.sci;

mixin(ShowModule!());

@safe:

struct Network {
    NetworkId id;
    TenantId tenantId;
    string name;
    string description;
    NetworkType networkType = NetworkType.tenant;
    NetworkStatus status = NetworkStatus.active;
    string cidr;
    string gateway;
    string dnsNameservers;
    bool isShared;
    bool isExternal;
    string availabilityZone;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
