/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.eam.domain.repositories.material_bom_repository;

import uim.platform.eam;

mixin(ShowModule!());

@safe:

interface MaterialBOMRepository {
    MaterialBOM[] findAll();
    MaterialBOM* findById(MaterialBOMId id);
    MaterialBOM[] findByTenant(TenantId tenantId);
    MaterialBOM[] findByEquipment(EquipmentId equipmentId);
    void save(MaterialBOM bom);
    void update(MaterialBOM bom);
    void remove(MaterialBOMId id);
}
