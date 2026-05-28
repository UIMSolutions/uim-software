/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.domain.repositories.configuration_item_repository;

import uim.platform.itil;

mixin(ShowModule!());

@safe:

interface ConfigurationItemRepository {
    ConfigurationItem[] findAll();
    ConfigurationItem* findById(ConfigurationItemId id);
    ConfigurationItem[] findByTenant(TenantId tenantId);
    ConfigurationItem[] findByStatus(CIStatus ciStatus);
    ConfigurationItem[] findByType(CIType ciType);
    ConfigurationItem[] findByOwner(string ownerId);
    void save(ConfigurationItem ci);
    void update(ConfigurationItem ci);
    void remove(ConfigurationItemId id);
}
