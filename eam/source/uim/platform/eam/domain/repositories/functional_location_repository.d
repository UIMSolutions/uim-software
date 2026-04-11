/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.eam.domain.repositories.functional_location_repository;

import uim.platform.eam;

mixin(ShowModule!());

@safe:

interface FunctionalLocationRepository {
    FunctionalLocation[] findAll();
    FunctionalLocation* findById(FunctionalLocationId id);
    FunctionalLocation[] findByTenant(TenantId tenantId);
    FunctionalLocation[] findByType(FunctionalLocationType locationType);
    FunctionalLocation[] findByParent(FunctionalLocationId parentId);
    void save(FunctionalLocation location);
    void update(FunctionalLocation location);
    void remove(FunctionalLocationId id);
}
