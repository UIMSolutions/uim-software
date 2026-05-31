module uim.platform.mes.domain.repositories.product_repository;

import uim.platform.mes.domain.entities.product;
import uim.platform.mes.domain.types;

@safe:

interface ProductRepository {
    Product[] findAll();
    Product* findById(ProductId id);
    void save(Product product);
    void update(Product product);
    void remove(ProductId id);
}