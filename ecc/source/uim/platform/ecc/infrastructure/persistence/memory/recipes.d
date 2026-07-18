module uim.platform.ecc.infrastructure.persistence.repositories.recipes;

import uim.platform.ecc;

@safe:

class MemoryRecipeRepository : RecipeRepository {
    private Recipe[] items;

    Recipe[] findAll() { return items.dup; }
    Recipe* findById(RecipeId id) @trusted {
        foreach (index, ref item; items) if (item.id == id) return &items[index];
        return null;
    }
    void save(Recipe value) { items ~= value; }
    void update(Recipe value) {
        foreach (index, ref item; items) if (item.id == value.id) { items[index] = value; return; }
    }
    void remove(RecipeId id) {
        Recipe[] next;
        foreach (item; items) if (item.id != id) next ~= item;
        items = next;
    }
}
