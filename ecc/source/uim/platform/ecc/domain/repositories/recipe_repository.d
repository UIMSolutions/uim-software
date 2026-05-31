module uim.platform.ecc.domain.repositories.recipe_repository;

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