/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.sci.domain.repositories.key_pair_repository;

import uim.platform.sci;

mixin(ShowModule!());

@safe:

interface KeyPairRepository {
    KeyPair[] findAll();
    KeyPair* findById(KeyPairId id);
    KeyPair[] findByTenant(TenantId tenantId);
    KeyPair[] findByType(KeyPairType keyPairType);
    KeyPair[] findByUser(UserId userId);
    void save(KeyPair keyPair);
    void update(KeyPair keyPair);
    void remove(KeyPairId id);
}
