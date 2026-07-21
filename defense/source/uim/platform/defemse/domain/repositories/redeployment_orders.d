module uim.platform.defense.domain.repositories.redeployment_orders;

import uim.platform.defense.domain.entities.redeployment_order;
import uim.platform.defense.domain.types;

@safe:

interface RedeploymentOrderRepository {
    RedeploymentOrder[] findAll();
    RedeploymentOrder* findById(RedeploymentOrderId id);
    void save(RedeploymentOrder order);
    void update(RedeploymentOrder order);
    void remove(RedeploymentOrderId id);
}