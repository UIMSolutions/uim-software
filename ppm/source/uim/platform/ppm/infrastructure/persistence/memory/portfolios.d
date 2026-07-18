module uim.platform.ppm.infrastructure.persistence.repositories.portfolios;

import uim.platform.ppm;

@safe:

class MemoryPortfolioRepository : PortfolioRepository {
    private Portfolio[] items;

    Portfolio[] findAll() { return items.dup; }

    Portfolio* findById(PortfolioId id) @trusted {
        foreach (index, ref item; items) if (item.id == id) return &items[index];
        return null;
    }

    void save(Portfolio value) { items ~= value; }

    void update(Portfolio value) {
        foreach (index, ref item; items) if (item.id == value.id) { items[index] = value; return; }
    }

    void remove(PortfolioId id) {
        Portfolio[] next;
        foreach (item; items) if (item.id != id) next ~= item;
        items = next;
    }
}
