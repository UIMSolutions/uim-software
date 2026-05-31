module uim.platform.ibp.domain.repositories.recipe_repository;

import uim.platform.ibp.domain.entities.recipe;
import uim.platform.ibp.domain.types;

@safe:

interface RecipeRepository {
    Recipe[] findAll();
    Recipe* findById(RecipeId id);
    void save(Recipe value);
    void update(Recipe value);
    void remove(RecipeId id);
}