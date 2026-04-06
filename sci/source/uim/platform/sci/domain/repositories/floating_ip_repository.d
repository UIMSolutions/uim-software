/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.sci.domain.repositories.floating_ip_repository;

import uim.platform.sci;

mixin(ShowModule!());

@safe:

interface FloatingIpRepository {
    FloatingIp[] findAll();
    FloatingIp* findById(FloatingIpId id);
    FloatingIp[] findByTenant(TenantId tenantId);
    FloatingIp[] findByStatus(FloatingIpStatus status);
    FloatingIp[] findByInstance(InstanceId instanceId);
    void save(FloatingIp floatingIp);
    void update(FloatingIp floatingIp);
    void remove(FloatingIpId id);
}
