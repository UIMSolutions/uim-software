module uim.platform.apm.infrastructure.persistence.repositories.portfolio_items;

import std.algorithm : remove;
import uim.platform.apm;

@safe:

class MemoryPortfolioItemRepository : PortfolioItemRepository {
    private ApplicationPortfolioItem[] store;

    ApplicationPortfolioItem[] findAll() { return store; }

    ApplicationPortfolioItem[] findByTenant(TenantId tenantId) {
        ApplicationPortfolioItem[] result;
        foreach (item; store) {
            if (item.tenantId == tenantId)
                result ~= item;
        }
        return result;
    }

    ApplicationPortfolioItem* findById(PortfolioItemId id) @trusted {
        foreach (idx, ref item; store) {
            if (item.id == id)
                return &store[idx];
        }
        return null;
    }

    void save(ApplicationPortfolioItem item) { store ~= item; }

    void update(ApplicationPortfolioItem item) {
        foreach (ref current; store) {
            if (current.id == item.id) {
                current = item;
                return;
            }
        }
    }

    void remove(PortfolioItemId id) {
        store = store.remove!(item => item.id == id);
    }
}
