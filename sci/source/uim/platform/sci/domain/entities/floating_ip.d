/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.sci.domain.entities.floating_ip;

import uim.platform.sci;

mixin(ShowModule!());

@safe:

struct FloatingIp {
    FloatingIpId id;
    TenantId tenantId;
    string name;
    string description;
    FloatingIpStatus status = FloatingIpStatus.active;
    string floatingIpAddress;
    string fixedIpAddress;
    NetworkId networkId;
    InstanceId instanceId;
    string routerId;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
