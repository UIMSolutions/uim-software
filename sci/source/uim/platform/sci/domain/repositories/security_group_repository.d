/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.sci.domain.repositories.security_group_repository;

import uim.platform.sci;

mixin(ShowModule!());

@safe:

interface SecurityGroupRepository {
    SecurityGroup[] findAll();
    SecurityGroup* findById(SecurityGroupId id);
    SecurityGroup[] findByTenant(TenantId tenantId);
    SecurityGroup[] findByDirection(SecurityGroupDirection direction);
    SecurityGroup[] findByProtocol(SecurityGroupProtocol protocol);
    void save(SecurityGroup securityGroup);
    void update(SecurityGroup securityGroup);
    void remove(SecurityGroupId id);
}
