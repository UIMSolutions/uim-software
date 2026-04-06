/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.sci.domain.repositories.volume_repository;

import uim.platform.sci;

mixin(ShowModule!());

@safe:

interface VolumeRepository {
    Volume[] findAll();
    Volume* findById(VolumeId id);
    Volume[] findByTenant(TenantId tenantId);
    Volume[] findByStatus(VolumeStatus status);
    Volume[] findByInstance(InstanceId instanceId);
    void save(Volume volume);
    void update(Volume volume);
    void remove(VolumeId id);
}
