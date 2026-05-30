module uim.platform.plm.domain.repositories.recipe_repository;

import uim.platform.plm.domain.entities.recipe;
import uim.platform.plm.domain.types;

@safe:

interface RecipeRepository {
    Recipe[] findAll();
    Recipe* findById(RecipeId id);
    void save(Recipe value);
    void update(Recipe value);
    void remove(RecipeId id);
}