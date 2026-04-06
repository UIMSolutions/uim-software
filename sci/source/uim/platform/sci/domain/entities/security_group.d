/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.sci.domain.entities.security_group;

import uim.platform.sci;

mixin(ShowModule!());

@safe:

struct SecurityGroup {
    SecurityGroupId id;
    TenantId tenantId;
    string name;
    string description;
    SecurityGroupDirection direction = SecurityGroupDirection.ingress;
    SecurityGroupProtocol protocol = SecurityGroupProtocol.tcp;
    string portRangeMin;
    string portRangeMax;
    string remoteIpPrefix;
    string remoteGroupId;
    string etherType;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
