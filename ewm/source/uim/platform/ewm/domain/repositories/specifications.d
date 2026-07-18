/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.ewm.domain.repositories.specifications;

import uim.platform.ewm.domain.entities.specification;
import uim.platform.ewm.domain.types;

@safe:

interface SpecificationRepository {
    Specification[] findAll();
    Specification* findById(SpecificationId id);
    void save(Specification value);
    void update(Specification value);
    void remove(SpecificationId id);
}