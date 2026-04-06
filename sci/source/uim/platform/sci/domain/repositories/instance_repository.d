/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.sci.domain.repositories.instance_repository;

import uim.platform.sci;

mixin(ShowModule!());

@safe:

interface InstanceRepository {
    Instance[] findAll();
    Instance* findById(InstanceId id);
    Instance[] findByTenant(TenantId tenantId);
    Instance[] findByStatus(InstanceStatus status);
    Instance[] findByAvailabilityZone(string zone);
    void save(Instance instance);
    void update(Instance instance);
    void remove(InstanceId id);
}
