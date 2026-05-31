module uim.platform.epd.domain.repositories.recipe_repository;

import uim.platform.epd.domain.entities.recipe;
import uim.platform.epd.domain.types;

@safe:

interface RecipeRepository {
    Recipe[] findAll();
    Recipe* findById(RecipeId id);
    void save(Recipe value);
    void update(Recipe value);
    void remove(RecipeId id);
}