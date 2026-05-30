module uim.platform.plm.domain.repositories.product_repository;

import uim.platform.plm.domain.entities.product;
import uim.platform.plm.domain.types;

@safe:

interface ProductRepository {
    Product[] findAll();
    Product* findById(ProductId id);
    void save(Product product);
    void update(Product product);
    void remove(ProductId id);
}