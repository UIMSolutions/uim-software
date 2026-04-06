/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.sci.domain.entities.volume;

import uim.platform.sci;

mixin(ShowModule!());

@safe:

struct Volume {
    VolumeId id;
    TenantId tenantId;
    string name;
    string description;
    string size;
    VolumeType volumeType = VolumeType.standard;
    VolumeStatus status = VolumeStatus.available;
    InstanceId instanceId;
    string availabilityZone;
    string snapshotId;
    string sourceVolumeId;
    bool encrypted;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
