module uim.platform.ecc.domain.repositories.product_repository;

import uim.platform.ecc.domain.entities.product;
import uim.platform.ecc.domain.types;

@safe:

interface ProductRepository {
    Product[] findAll();
    Product* findById(ProductId id);
    void save(Product product);
    void update(Product product);
    void remove(ProductId id);
}