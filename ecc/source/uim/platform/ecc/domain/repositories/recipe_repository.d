/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.ecc.domain.repositories.recipes;

import uim.platform.ecc.domain.entities.recipe;
import uim.platform.ecc.domain.types;

@safe:

interface RecipeRepository {
    Recipe[] findAll();
    Recipe* findById(RecipeId id);
    void save(Recipe value);
    void update(Recipe value);
    void remove(RecipeId id);
}