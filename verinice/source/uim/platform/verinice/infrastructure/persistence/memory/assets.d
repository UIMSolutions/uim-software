module uim.platform.verinice.infrastructure.persistence.memory.assets;

import uim.platform.verinice;

@safe:

class MemoryAssetRepository : AssetRepository {
    private Asset[] items;

    Asset[] findAll() {
        return items.dup;
    }

    Asset* findById(AssetId id) @trusted {
        foreach (index, ref item; items) {
            if (item.id == id)
                return &items[index];
        }
        return null;
    }

    void save(Asset value) {
        items ~= value;
    }

    void update(Asset value) {
        foreach (index, ref item; items) {
            if (item.id == value.id) {
                items[index] = value;
                return;
            }
        }
    }

    void remove(AssetId id) {
        Asset[] next;
        foreach (item; items) {
            if (item.id != id)
                next ~= item;
        }
        items = next;
    }
}
