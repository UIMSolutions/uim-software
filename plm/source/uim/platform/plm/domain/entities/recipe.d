module uim.platform.plm.domain.entities.recipe;

import uim.platform.plm.domain.types;

@safe:

struct Recipe {
    RecipeId id;
    TenantId tenantId;
    ProductId productId;
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