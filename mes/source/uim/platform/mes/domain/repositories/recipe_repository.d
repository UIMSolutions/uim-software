module uim.platform.mes.domain.repositories.recipe_repository;

import uim.platform.mes.domain.entities.recipe;
import uim.platform.mes.domain.types;

@safe:

interface RecipeRepository {
    Recipe[] findAll();
    Recipe* findById(RecipeId id);
    void save(Recipe value);
    void update(Recipe value);
    void remove(RecipeId id);
}