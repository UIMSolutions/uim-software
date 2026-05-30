module uim.platform.defemse.domain.repositories.redeployment_order_repository;

import uim.platform.defemse.domain.entities.redeployment_order;
import uim.platform.defemse.domain.types;

@safe:

interface RedeploymentOrderRepository {
    RedeploymentOrder[] findAll();
    RedeploymentOrder* findById(RedeploymentOrderId id);
    void save(RedeploymentOrder order);
    void update(RedeploymentOrder order);
    void remove(RedeploymentOrderId id);
}