module uim.platform.mii.domain.repositories.recipe_repository;

import uim.platform.mii.domain.entities.recipe;
import uim.platform.mii.domain.types;

@safe:

interface RecipeRepository {
    Recipe[] findAll();
    Recipe* findById(RecipeId id);
    void save(Recipe value);
    void update(Recipe value);
    void remove(RecipeId id);
}