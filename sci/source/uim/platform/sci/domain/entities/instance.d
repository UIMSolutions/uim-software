/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.sci.domain.entities.instance;

import uim.platform.sci;

mixin(ShowModule!());

@safe:

struct Instance {
    InstanceId id;
    TenantId tenantId;
    string name;
    string description;
    string flavorId;
    FlavorCategory flavorCategory = FlavorCategory.general;
    string imageId;
    InstanceStatus status = InstanceStatus.active;
    InstancePowerState powerState = InstancePowerState.running;
    string availabilityZone;
    string hostId;
    KeyPairId keyPairId;
    string networkIds;
    string securityGroupIds;
    string serverGroupId;
    string userData;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
