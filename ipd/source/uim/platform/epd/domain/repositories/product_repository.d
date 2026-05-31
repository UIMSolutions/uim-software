module uim.platform.epd.domain.repositories.product_repository;

import uim.platform.epd.domain.entities.product;
import uim.platform.epd.domain.types;

@safe:

interface ProductRepository {
    Product[] findAll();
    Product* findById(ProductId id);
    void save(Product product);
    void update(Product product);
    void remove(ProductId id);
}