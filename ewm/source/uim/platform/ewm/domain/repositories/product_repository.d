module uim.platform.ewm.domain.repositories.product_repository;

import uim.platform.ewm.domain.entities.product;
import uim.platform.ewm.domain.types;

@safe:

interface ProductRepository {
    Product[] findAll();
    Product* findById(ProductId id);
    void save(Product product);
    void update(Product product);
    void remove(ProductId id);
}