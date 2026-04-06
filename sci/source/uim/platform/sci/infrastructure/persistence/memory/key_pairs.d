/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.sci.infrastructure.persistence.memory.key_pairs;

import uim.platform.sci;

mixin(ShowModule!());

@safe:

class MemoryKeyPairRepository : KeyPairRepository {
    private KeyPair[] store;

    KeyPair[] findAll() { return store; }

    KeyPair* findById(KeyPairId id) {
        foreach (ref e; store)
            if (e.id == id) return &e;
        return null;
    }

    KeyPair[] findByTenant(TenantId tenantId) {
        KeyPair[] result;
        foreach (ref e; store)
            if (e.tenantId == tenantId) result ~= e;
        return result;
    }

    KeyPair[] findByType(KeyPairType keyPairType) {
        KeyPair[] result;
        foreach (ref e; store)
            if (e.keyPairType == keyPairType) result ~= e;
        return result;
    }

    KeyPair[] findByUser(UserId userId) {
        KeyPair[] result;
        foreach (ref e; store)
            if (e.userId == userId) result ~= e;
        return result;
    }

    void save(KeyPair keyPair) { store ~= keyPair; }

    void update(KeyPair keyPair) {
        foreach (ref e; store)
            if (e.id == keyPair.id) { e = keyPair; return; }
    }

    void remove(KeyPairId id) {
        import std.algorithm : remove;
        store = store.remove!(e => e.id == id);
    }
}
