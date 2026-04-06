/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.sci.domain.repositories.network_repository;

import uim.platform.sci;

mixin(ShowModule!());

@safe:

interface NetworkRepository {
    Network[] findAll();
    Network* findById(NetworkId id);
    Network[] findByTenant(TenantId tenantId);
    Network[] findByType(NetworkType networkType);
    Network[] findByStatus(NetworkStatus status);
    void save(Network network);
    void update(Network network);
    void remove(NetworkId id);
}
