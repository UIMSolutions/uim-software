module uim.platform.ibp.domain.repositories.product_repository;

import uim.platform.ibp.domain.entities.product;
import uim.platform.ibp.domain.types;

@safe:

interface ProductRepository {
    Product[] findAll();
    Product* findById(ProductId id);
    void save(Product product);
    void update(Product product);
    void remove(ProductId id);
}