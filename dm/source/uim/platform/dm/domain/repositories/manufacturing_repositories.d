module uim.platform.dm.domain.repositories.manufacturing_repositories;

import uim.platform.dm.domain.entities.manufacturing_entities;
import uim.platform.dm.domain.types;

@safe:

interface ProductionOrderRepository {
    ProductionOrder[] findAll();
    ProductionOrder* findById(ProductionOrderId id);
    void save(ProductionOrder value);
    void update(ProductionOrder value);
    void remove(ProductionOrderId id);
}

interface OperationActivityRepository {
    OperationActivity[] findAll();
    OperationActivity* findById(OperationActivityId id);
    void save(OperationActivity value);
    void update(OperationActivity value);
    void remove(OperationActivityId id);
}

interface WorkCenterRepository {
    WorkCenter[] findAll();
    WorkCenter* findById(WorkCenterId id);
    void save(WorkCenter value);
    void update(WorkCenter value);
    void remove(WorkCenterId id);
}

interface ResourceRepository {
    Resource[] findAll();
    Resource* findById(ResourceId id);
    void save(Resource value);
    void update(Resource value);
    void remove(ResourceId id);
}

interface MaterialRepository {
    Material[] findAll();
    Material* findById(MaterialId id);
    void save(Material value);
    void update(Material value);
    void remove(MaterialId id);
}

interface ShopFloorControlRepository {
    ShopFloorControl[] findAll();
    ShopFloorControl* findById(ShopFloorControlId id);
    void save(ShopFloorControl value);
    void update(ShopFloorControl value);
    void remove(ShopFloorControlId id);
}

interface WorkInstructionRepository {
    WorkInstruction[] findAll();
    WorkInstruction* findById(WorkInstructionId id);
    void save(WorkInstruction value);
    void update(WorkInstruction value);
    void remove(WorkInstructionId id);
}

interface QualityInspectionRepository {
    QualityInspection[] findAll();
    QualityInspection* findById(QualityInspectionId id);
    void save(QualityInspection value);
    void update(QualityInspection value);
    void remove(QualityInspectionId id);
}

interface NonconformanceRepository {
    Nonconformance[] findAll();
    Nonconformance* findById(NonconformanceId id);
    void save(Nonconformance value);
    void update(Nonconformance value);
    void remove(NonconformanceId id);
}

interface GenealogyRecordRepository {
    GenealogyRecord[] findAll();
    GenealogyRecord* findById(GenealogyRecordId id);
    void save(GenealogyRecord value);
    void update(GenealogyRecord value);
    void remove(GenealogyRecordId id);
}
