module uim.platform.mes.application.usecases.manage.recipes;

import uim.platform.mes;

@safe:

class ManageRecipesUseCase : UIMUseCase {
    private RecipeRepository repo;
    this(RecipeRepository repo) { this.repo = repo; }
    Recipe[] list() { return repo.findAll(); }
    Recipe* get_(RecipeId id) { return repo.findById(id); }
    CommandResult create(RecipeDTO dto) {
        Recipe value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.orderId = dto.orderId;
        value.name = dto.name;
        value.description = dto.description;
        value.recipeType = dto.recipeType;
        value.status = dto.status.length ? dto.status : value.status;
        value.recipeNumber = dto.recipeNumber;
        value.yieldValue = dto.yieldValue;
        value.yieldUnit = dto.yieldUnit;
        value.batchSize = dto.batchSize;
        value.batchUnit = dto.batchUnit;
        value.shelfLife = dto.shelfLife;
        value.storageConditions = dto.storageConditions;
        value.ingredients = dto.ingredients;
        value.instructions = dto.instructions;
        value.createdBy = dto.createdBy;
        if (!MesValidator.isValidRecipe(value)) {
            return CommandResult(false, "", "Invalid recipe data");
        }
        repo.save(value);
        return CommandResult(true, dto.id, "");
    }
    CommandResult update(RecipeDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) {
            return CommandResult(false, "", "Recipe not found");
        }
        if (dto.name.length) existing.name = dto.name;
        if (dto.description.length) existing.description = dto.description;
        if (dto.recipeType.length) existing.recipeType = dto.recipeType;
        if (dto.status.length) existing.status = dto.status;
        if (dto.recipeNumber.length) existing.recipeNumber = dto.recipeNumber;
        if (dto.yieldValue.length) existing.yieldValue = dto.yieldValue;
        if (dto.yieldUnit.length) existing.yieldUnit = dto.yieldUnit;
        if (dto.batchSize.length) existing.batchSize = dto.batchSize;
        if (dto.batchUnit.length) existing.batchUnit = dto.batchUnit;
        if (dto.shelfLife.length) existing.shelfLife = dto.shelfLife;
        if (dto.storageConditions.length) existing.storageConditions = dto.storageConditions;
        if (dto.ingredients.length) existing.ingredients = dto.ingredients;
        if (dto.instructions.length) existing.instructions = dto.instructions;
        if (dto.modifiedBy.length) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }
    CommandResult remove(RecipeId id) {
        auto existing = repo.findById(id);
        if (existing is null) {
            return CommandResult(false, "", "Recipe not found");
        }
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
