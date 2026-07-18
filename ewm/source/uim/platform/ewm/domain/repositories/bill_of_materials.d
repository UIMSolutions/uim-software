/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.ewm.domain.repositories.bill_of_materials;

import uim.platform.ewm.domain.entities.bill_of_material;
import uim.platform.ewm.domain.types;

@safe:

interface BillOfMaterialRepository {
    BillOfMaterial[] findAll();
    BillOfMaterial* findById(BillOfMaterialId id);
    void save(BillOfMaterial value);
    void update(BillOfMaterial value);
    void remove(BillOfMaterialId id);
}