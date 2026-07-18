module uim.platform.defemse.infrastructure.persistence.repositories.redeployment_orders;

import uim.platform.defemse;

@safe:

class MemoryRedeploymentOrderRepository : RedeploymentOrderRepository {
    private RedeploymentOrder[] items;

    RedeploymentOrder[] findAll() {
        return items.dup;
    }

    RedeploymentOrder* findById(RedeploymentOrderId id) {
        foreach (ref item; items) {
            if (item.id == id) return &item;
        }
        return null;
    }

    void save(RedeploymentOrder order) {
        items ~= order;
    }

    void update(RedeploymentOrder order) {
        foreach (index, ref item; items) {
            if (item.id == order.id) {
                items[index] = order;
                return;
            }
        }
    }

    void remove(RedeploymentOrderId id) {
        RedeploymentOrder[] next;
        foreach (item; items) if (item.id != id) next ~= item;
        items = next;
    }
}