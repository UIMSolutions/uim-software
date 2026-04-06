/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.sci.infrastructure.persistence.memory.security_groups;

import uim.platform.sci;

mixin(ShowModule!());

@safe:

class MemorySecurityGroupRepository : SecurityGroupRepository {
    private SecurityGroup[] store;

    SecurityGroup[] findAll() { return store; }

    SecurityGroup* findById(SecurityGroupId id) {
        foreach (ref e; store)
            if (e.id == id) return &e;
        return null;
    }

    SecurityGroup[] findByTenant(TenantId tenantId) {
        SecurityGroup[] result;
        foreach (ref e; store)
            if (e.tenantId == tenantId) result ~= e;
        return result;
    }

    SecurityGroup[] findByDirection(SecurityGroupDirection direction) {
        SecurityGroup[] result;
        foreach (ref e; store)
            if (e.direction == direction) result ~= e;
        return result;
    }

    SecurityGroup[] findByProtocol(SecurityGroupProtocol protocol) {
        SecurityGroup[] result;
        foreach (ref e; store)
            if (e.protocol == protocol) result ~= e;
        return result;
    }

    void save(SecurityGroup securityGroup) { store ~= securityGroup; }

    void update(SecurityGroup securityGroup) {
        foreach (ref e; store)
            if (e.id == securityGroup.id) { e = securityGroup; return; }
    }

    void remove(SecurityGroupId id) {
        import std.algorithm : remove;
        store = store.remove!(e => e.id == id);
    }
}
