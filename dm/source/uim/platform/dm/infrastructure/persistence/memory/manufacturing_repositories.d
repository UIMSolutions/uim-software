module uim.platform.dm.infrastructure.persistence.memory.manufacturing_repositories;

import std.algorithm : remove;

import uim.platform.dm.domain.entities.manufacturing_entities;
import uim.platform.dm.domain.repositories.manufacturing_repositories;
import uim.platform.dm.domain.types;

@safe:

class MemoryProductionOrderRepository : ProductionOrderRepository {
    private ProductionOrder[] store;

    ProductionOrder[] findAll() { return store; }

    private @trusted ProductionOrder* ptr(ProductionOrderId id) {
        foreach (i, ref value; store)
            if (value.id == id) return &store[i];
        return null;
    }

    ProductionOrder* findById(ProductionOrderId id) { return ptr(id); }
    void save(ProductionOrder value) { store ~= value; }

    void update(ProductionOrder value) {
        auto current = ptr(value.id);
        if (current !is null) *current = value;
    }

    void remove(ProductionOrderId id) { store = store.remove!(x => x.id == id); }
}

class MemoryOperationActivityRepository : OperationActivityRepository {
    private OperationActivity[] store;

    OperationActivity[] findAll() { return store; }

    private @trusted OperationActivity* ptr(OperationActivityId id) {
        foreach (i, ref value; store)
            if (value.id == id) return &store[i];
        return null;
    }

    OperationActivity* findById(OperationActivityId id) { return ptr(id); }
    void save(OperationActivity value) { store ~= value; }

    void update(OperationActivity value) {
        auto current = ptr(value.id);
        if (current !is null) *current = value;
    }

    void remove(OperationActivityId id) { store = store.remove!(x => x.id == id); }
}

class MemoryWorkCenterRepository : WorkCenterRepository {
    private WorkCenter[] store;

    WorkCenter[] findAll() { return store; }

    private @trusted WorkCenter* ptr(WorkCenterId id) {
        foreach (i, ref value; store)
            if (value.id == id) return &store[i];
        return null;
    }

    WorkCenter* findById(WorkCenterId id) { return ptr(id); }
    void save(WorkCenter value) { store ~= value; }

    void update(WorkCenter value) {
        auto current = ptr(value.id);
        if (current !is null) *current = value;
    }

    void remove(WorkCenterId id) { store = store.remove!(x => x.id == id); }
}

class MemoryResourceRepository : ResourceRepository {
    private Resource[] store;

    Resource[] findAll() { return store; }

    private @trusted Resource* ptr(ResourceId id) {
        foreach (i, ref value; store)
            if (value.id == id) return &store[i];
        return null;
    }

    Resource* findById(ResourceId id) { return ptr(id); }
    void save(Resource value) { store ~= value; }

    void update(Resource value) {
        auto current = ptr(value.id);
        if (current !is null) *current = value;
    }

    void remove(ResourceId id) { store = store.remove!(x => x.id == id); }
}

class MemoryMaterialRepository : MaterialRepository {
    private Material[] store;

    Material[] findAll() { return store; }

    private @trusted Material* ptr(MaterialId id) {
        foreach (i, ref value; store)
            if (value.id == id) return &store[i];
        return null;
    }

    Material* findById(MaterialId id) { return ptr(id); }
    void save(Material value) { store ~= value; }

    void update(Material value) {
        auto current = ptr(value.id);
        if (current !is null) *current = value;
    }

    void remove(MaterialId id) { store = store.remove!(x => x.id == id); }
}

class MemoryShopFloorControlRepository : ShopFloorControlRepository {
    private ShopFloorControl[] store;

    ShopFloorControl[] findAll() { return store; }

    private @trusted ShopFloorControl* ptr(ShopFloorControlId id) {
        foreach (i, ref value; store)
            if (value.id == id) return &store[i];
        return null;
    }

    ShopFloorControl* findById(ShopFloorControlId id) { return ptr(id); }
    void save(ShopFloorControl value) { store ~= value; }

    void update(ShopFloorControl value) {
        auto current = ptr(value.id);
        if (current !is null) *current = value;
    }

    void remove(ShopFloorControlId id) { store = store.remove!(x => x.id == id); }
}

class MemoryWorkInstructionRepository : WorkInstructionRepository {
    private WorkInstruction[] store;

    WorkInstruction[] findAll() { return store; }

    private @trusted WorkInstruction* ptr(WorkInstructionId id) {
        foreach (i, ref value; store)
            if (value.id == id) return &store[i];
        return null;
    }

    WorkInstruction* findById(WorkInstructionId id) { return ptr(id); }
    void save(WorkInstruction value) { store ~= value; }

    void update(WorkInstruction value) {
        auto current = ptr(value.id);
        if (current !is null) *current = value;
    }

    void remove(WorkInstructionId id) { store = store.remove!(x => x.id == id); }
}

class MemoryQualityInspectionRepository : QualityInspectionRepository {
    private QualityInspection[] store;

    QualityInspection[] findAll() { return store; }

    private @trusted QualityInspection* ptr(QualityInspectionId id) {
        foreach (i, ref value; store)
            if (value.id == id) return &store[i];
        return null;
    }

    QualityInspection* findById(QualityInspectionId id) { return ptr(id); }
    void save(QualityInspection value) { store ~= value; }

    void update(QualityInspection value) {
        auto current = ptr(value.id);
        if (current !is null) *current = value;
    }

    void remove(QualityInspectionId id) { store = store.remove!(x => x.id == id); }
}

class MemoryNonconformanceRepository : NonconformanceRepository {
    private Nonconformance[] store;

    Nonconformance[] findAll() { return store; }

    private @trusted Nonconformance* ptr(NonconformanceId id) {
        foreach (i, ref value; store)
            if (value.id == id) return &store[i];
        return null;
    }

    Nonconformance* findById(NonconformanceId id) { return ptr(id); }
    void save(Nonconformance value) { store ~= value; }

    void update(Nonconformance value) {
        auto current = ptr(value.id);
        if (current !is null) *current = value;
    }

    void remove(NonconformanceId id) { store = store.remove!(x => x.id == id); }
}

class MemoryGenealogyRecordRepository : GenealogyRecordRepository {
    private GenealogyRecord[] store;

    GenealogyRecord[] findAll() { return store; }

    private @trusted GenealogyRecord* ptr(GenealogyRecordId id) {
        foreach (i, ref value; store)
            if (value.id == id) return &store[i];
        return null;
    }

    GenealogyRecord* findById(GenealogyRecordId id) { return ptr(id); }
    void save(GenealogyRecord value) { store ~= value; }

    void update(GenealogyRecord value) {
        auto current = ptr(value.id);
        if (current !is null) *current = value;
    }

    void remove(GenealogyRecordId id) { store = store.remove!(x => x.id == id); }
}
