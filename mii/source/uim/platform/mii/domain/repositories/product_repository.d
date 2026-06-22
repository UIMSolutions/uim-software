module uim.platform.mii.domain.repositories.product_repository;

import uim.platform.mii.domain.entities.product;
import uim.platform.mii.domain.types;

@safe:

interface ProductRepository {
    Product[] findAll();
    Product* findById(ProductId id);
    void save(Product product);
    void update(Product product);
    void remove(ProductId id);
}