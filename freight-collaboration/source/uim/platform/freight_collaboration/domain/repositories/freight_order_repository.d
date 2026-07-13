module uim.platform.freight_collaboration.domain.repositories.freight_order_repository;

import uim.platform.freight_collaboration.domain.entities.freight_order;
import uim.platform.freight_collaboration.domain.types;

@safe:

interface FreightOrderRepository {
    FreightOrder[] findAll();
    FreightOrder* findById(FreightOrderId id);
    void save(FreightOrder value);
    void update(FreightOrder value);
    void remove(FreightOrderId id);
}
