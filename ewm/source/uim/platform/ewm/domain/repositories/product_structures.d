/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.ewm.domain.repositories.product_structures;

import uim.platform.ewm.domain.entities.product_structure;
import uim.platform.ewm.domain.types;

@safe:

interface ProductStructureRepository {
    ProductStructure[] findAll();
    ProductStructure* findById(ProductStructureId id);
    void save(ProductStructure value);
    void update(ProductStructure value);
    void remove(ProductStructureId id);
}