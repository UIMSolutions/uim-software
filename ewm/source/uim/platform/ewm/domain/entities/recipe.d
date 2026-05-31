module uim.platform.ewm.domain.entities.recipe;

import uim.platform.ewm.domain.types;

@safe:

struct Recipe {
    RecipeId id;
    TenantId tenantId;
    ProductId warehouseId;
    string name;
    string description;
    string recipeType;
    string status = "draft";
    string recipeNumber;
    string yieldValue;
    string yieldUnit;
    string batchSize;
    string batchUnit;
    string shelfLife;
    string storageConditions;
    string ingredients;
    string instructions;
    UserId createdBy;
    UserId modifiedBy;
    string createdAt;
    string modifiedAt;
}