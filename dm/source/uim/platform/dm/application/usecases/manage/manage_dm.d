module uim.platform.dm.application.usecases.manage.manage_dm;

import std.string : toLower;

import uim.platform.dm.application.dto;
import uim.platform.dm.domain.entities.manufacturing_entities;
import uim.platform.dm.domain.repositories.manufacturing_repositories;
import uim.platform.dm.domain.services.dm_validator;
import uim.platform.dm.domain.types;

@safe:

private OrderStatus parseOrderStatus(string value, OrderStatus fallback = OrderStatus.planned) {
    switch (value.toLower()) {
        case "planned": return OrderStatus.planned;
        case "released": return OrderStatus.released;
        case "inexecution": return OrderStatus.inExecution;
        case "paused": return OrderStatus.paused;
        case "technicallycomplete": return OrderStatus.technicallyComplete;
        case "closed": return OrderStatus.closed;
        default: return fallback;
    }
}

private OperationStatus parseOperationStatus(string value, OperationStatus fallback = OperationStatus.ready) {
    switch (value.toLower()) {
        case "ready": return OperationStatus.ready;
        case "started": return OperationStatus.started;
        case "blocked": return OperationStatus.blocked;
        case "completed": return OperationStatus.completed;
        case "skipped": return OperationStatus.skipped;
        default: return fallback;
    }
}

private ResourceType parseResourceType(string value, ResourceType fallback = ResourceType.machine) {
    switch (value.toLower()) {
        case "machine": return ResourceType.machine;
        case "labor": return ResourceType.labor;
        case "tool": return ResourceType.tool;
        case "fixture": return ResourceType.fixture;
        case "device": return ResourceType.device;
        default: return fallback;
    }
}

private ControlMode parseControlMode(string value, ControlMode fallback = ControlMode.pull) {
    switch (value.toLower()) {
        case "pull": return ControlMode.pull;
        case "push": return ControlMode.push;
        case "mixed": return ControlMode.mixed;
        default: return fallback;
    }
}

private InspectionStatus parseInspectionStatus(string value, InspectionStatus fallback = InspectionStatus.pending) {
    switch (value.toLower()) {
        case "pending": return InspectionStatus.pending;
        case "inprogress": return InspectionStatus.inProgress;
        case "accepted": return InspectionStatus.accepted;
        case "rejected": return InspectionStatus.rejected;
        case "reworkrequired": return InspectionStatus.reworkRequired;
        default: return fallback;
    }
}

private NonconformanceSeverity parseNonconformanceSeverity(string value, NonconformanceSeverity fallback = NonconformanceSeverity.minor) {
    switch (value.toLower()) {
        case "minor": return NonconformanceSeverity.minor;
        case "major": return NonconformanceSeverity.major;
        case "critical": return NonconformanceSeverity.critical;
        default: return fallback;
    }
}

class ManageProductionOrdersUseCase {
    private ProductionOrderRepository repo;

    this(ProductionOrderRepository repo) { this.repo = repo; }

    ProductionOrder[] list() { return repo.findAll(); }
    ProductionOrder* get_(ProductionOrderId id) { return repo.findById(id); }

    CommandResult create(ProductionOrderDTO dto) {
        ProductionOrder value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.orderNumber = dto.orderNumber;
        value.materialId = dto.materialId;
        value.plant = dto.plant;
        value.quantity = dto.quantity;
        value.unit = dto.unit;
        value.scheduledStart = dto.scheduledStart;
        value.scheduledEnd = dto.scheduledEnd;
        value.status = parseOrderStatus(dto.status);
        value.createdBy = dto.createdBy;

        if (!DMValidator.valid(value)) return CommandResult(false, "", "Invalid production order data");
        repo.save(value);
        return CommandResult(true, value.id, "");
    }

    CommandResult update(ProductionOrderDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) return CommandResult(false, "", "Production order not found");

        if (dto.plant.length > 0) existing.plant = dto.plant;
        if (dto.quantity.length > 0) existing.quantity = dto.quantity;
        if (dto.unit.length > 0) existing.unit = dto.unit;
        if (dto.scheduledStart.length > 0) existing.scheduledStart = dto.scheduledStart;
        if (dto.scheduledEnd.length > 0) existing.scheduledEnd = dto.scheduledEnd;
        if (dto.status.length > 0) existing.status = parseOrderStatus(dto.status, existing.status);
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;

        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(ProductionOrderId id) {
        auto existing = repo.findById(id);
        if (existing is null) return CommandResult(false, "", "Production order not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}

class ManageOperationActivitiesUseCase {
    private OperationActivityRepository repo;

    this(OperationActivityRepository repo) { this.repo = repo; }

    OperationActivity[] list() { return repo.findAll(); }
    OperationActivity* get_(OperationActivityId id) { return repo.findById(id); }

    CommandResult create(OperationActivityDTO dto) {
        OperationActivity value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.productionOrderId = dto.productionOrderId;
        value.operationCode = dto.operationCode;
        value.workCenterId = dto.workCenterId;
        value.sequence = dto.sequence;
        value.plannedDuration = dto.plannedDuration;
        value.status = parseOperationStatus(dto.status);
        value.createdBy = dto.createdBy;

        if (!DMValidator.valid(value)) return CommandResult(false, "", "Invalid operation activity data");
        repo.save(value);
        return CommandResult(true, value.id, "");
    }

    CommandResult update(OperationActivityDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) return CommandResult(false, "", "Operation activity not found");

        if (dto.workCenterId.length > 0) existing.workCenterId = dto.workCenterId;
        if (dto.sequence.length > 0) existing.sequence = dto.sequence;
        if (dto.plannedDuration.length > 0) existing.plannedDuration = dto.plannedDuration;
        if (dto.status.length > 0) existing.status = parseOperationStatus(dto.status, existing.status);
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;

        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(OperationActivityId id) {
        auto existing = repo.findById(id);
        if (existing is null) return CommandResult(false, "", "Operation activity not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}

class ManageWorkCentersUseCase {
    private WorkCenterRepository repo;

    this(WorkCenterRepository repo) { this.repo = repo; }

    WorkCenter[] list() { return repo.findAll(); }
    WorkCenter* get_(WorkCenterId id) { return repo.findById(id); }

    CommandResult create(WorkCenterDTO dto) {
        WorkCenter value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.centerCode = dto.centerCode;
        value.description = dto.description;
        value.plant = dto.plant;
        value.capacity = dto.capacity;
        value.capacityUnit = dto.capacityUnit;
        value.createdBy = dto.createdBy;

        if (!DMValidator.valid(value)) return CommandResult(false, "", "Invalid work center data");
        repo.save(value);
        return CommandResult(true, value.id, "");
    }

    CommandResult update(WorkCenterDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) return CommandResult(false, "", "Work center not found");

        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.plant.length > 0) existing.plant = dto.plant;
        if (dto.capacity.length > 0) existing.capacity = dto.capacity;
        if (dto.capacityUnit.length > 0) existing.capacityUnit = dto.capacityUnit;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;

        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(WorkCenterId id) {
        auto existing = repo.findById(id);
        if (existing is null) return CommandResult(false, "", "Work center not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}

class ManageResourcesUseCase {
    private ResourceRepository repo;

    this(ResourceRepository repo) { this.repo = repo; }

    Resource[] list() { return repo.findAll(); }
    Resource* get_(ResourceId id) { return repo.findById(id); }

    CommandResult create(ResourceDTO dto) {
        Resource value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.resourceCode = dto.resourceCode;
        value.workCenterId = dto.workCenterId;
        value.resourceType = parseResourceType(dto.resourceType);
        value.availability = dto.availability;
        value.createdBy = dto.createdBy;

        if (!DMValidator.valid(value)) return CommandResult(false, "", "Invalid resource data");
        repo.save(value);
        return CommandResult(true, value.id, "");
    }

    CommandResult update(ResourceDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) return CommandResult(false, "", "Resource not found");

        if (dto.workCenterId.length > 0) existing.workCenterId = dto.workCenterId;
        if (dto.availability.length > 0) existing.availability = dto.availability;
        if (dto.resourceType.length > 0) existing.resourceType = parseResourceType(dto.resourceType, existing.resourceType);
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;

        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(ResourceId id) {
        auto existing = repo.findById(id);
        if (existing is null) return CommandResult(false, "", "Resource not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}

class ManageMaterialsUseCase {
    private MaterialRepository repo;

    this(MaterialRepository repo) { this.repo = repo; }

    Material[] list() { return repo.findAll(); }
    Material* get_(MaterialId id) { return repo.findById(id); }

    CommandResult create(MaterialDTO dto) {
        Material value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.materialNumber = dto.materialNumber;
        value.description = dto.description;
        value.baseUnit = dto.baseUnit;
        value.revision = dto.revision;
        value.createdBy = dto.createdBy;

        if (!DMValidator.valid(value)) return CommandResult(false, "", "Invalid material data");
        repo.save(value);
        return CommandResult(true, value.id, "");
    }

    CommandResult update(MaterialDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) return CommandResult(false, "", "Material not found");

        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.baseUnit.length > 0) existing.baseUnit = dto.baseUnit;
        if (dto.revision.length > 0) existing.revision = dto.revision;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;

        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(MaterialId id) {
        auto existing = repo.findById(id);
        if (existing is null) return CommandResult(false, "", "Material not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}

class ManageShopFloorControlsUseCase {
    private ShopFloorControlRepository repo;

    this(ShopFloorControlRepository repo) { this.repo = repo; }

    ShopFloorControl[] list() { return repo.findAll(); }
    ShopFloorControl* get_(ShopFloorControlId id) { return repo.findById(id); }

    CommandResult create(ShopFloorControlDTO dto) {
        ShopFloorControl value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.productionOrderId = dto.productionOrderId;
        value.dispatchRule = dto.dispatchRule;
        value.priority = dto.priority;
        value.mode = parseControlMode(dto.mode);
        value.releaseStrategy = dto.releaseStrategy;
        value.createdBy = dto.createdBy;

        if (!DMValidator.valid(value)) return CommandResult(false, "", "Invalid shop floor control data");
        repo.save(value);
        return CommandResult(true, value.id, "");
    }

    CommandResult update(ShopFloorControlDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) return CommandResult(false, "", "Shop floor control not found");

        if (dto.dispatchRule.length > 0) existing.dispatchRule = dto.dispatchRule;
        if (dto.priority.length > 0) existing.priority = dto.priority;
        if (dto.mode.length > 0) existing.mode = parseControlMode(dto.mode, existing.mode);
        if (dto.releaseStrategy.length > 0) existing.releaseStrategy = dto.releaseStrategy;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;

        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(ShopFloorControlId id) {
        auto existing = repo.findById(id);
        if (existing is null) return CommandResult(false, "", "Shop floor control not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}

class ManageWorkInstructionsUseCase {
    private WorkInstructionRepository repo;

    this(WorkInstructionRepository repo) { this.repo = repo; }

    WorkInstruction[] list() { return repo.findAll(); }
    WorkInstruction* get_(WorkInstructionId id) { return repo.findById(id); }

    CommandResult create(WorkInstructionDTO dto) {
        WorkInstruction value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.operationActivityId = dto.operationActivityId;
        value.title = dto.title;
        value.documentRef = dto.documentRef;
        value.instructionVersion = dto.instructionVersion;
        value.language = dto.language;
        value.createdBy = dto.createdBy;

        if (!DMValidator.valid(value)) return CommandResult(false, "", "Invalid work instruction data");
        repo.save(value);
        return CommandResult(true, value.id, "");
    }

    CommandResult update(WorkInstructionDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) return CommandResult(false, "", "Work instruction not found");

        if (dto.title.length > 0) existing.title = dto.title;
        if (dto.documentRef.length > 0) existing.documentRef = dto.documentRef;
        if (dto.instructionVersion.length > 0) existing.instructionVersion = dto.instructionVersion;
        if (dto.language.length > 0) existing.language = dto.language;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;

        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(WorkInstructionId id) {
        auto existing = repo.findById(id);
        if (existing is null) return CommandResult(false, "", "Work instruction not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}

class ManageQualityInspectionsUseCase {
    private QualityInspectionRepository repo;

    this(QualityInspectionRepository repo) { this.repo = repo; }

    QualityInspection[] list() { return repo.findAll(); }
    QualityInspection* get_(QualityInspectionId id) { return repo.findById(id); }

    CommandResult create(QualityInspectionDTO dto) {
        QualityInspection value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.productionOrderId = dto.productionOrderId;
        value.characteristic = dto.characteristic;
        value.sampleSize = dto.sampleSize;
        value.resultValue = dto.resultValue;
        value.status = parseInspectionStatus(dto.status);
        value.inspector = dto.inspector;
        value.createdBy = dto.createdBy;

        if (!DMValidator.valid(value)) return CommandResult(false, "", "Invalid quality inspection data");
        repo.save(value);
        return CommandResult(true, value.id, "");
    }

    CommandResult update(QualityInspectionDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) return CommandResult(false, "", "Quality inspection not found");

        if (dto.sampleSize.length > 0) existing.sampleSize = dto.sampleSize;
        if (dto.resultValue.length > 0) existing.resultValue = dto.resultValue;
        if (dto.inspector.length > 0) existing.inspector = dto.inspector;
        if (dto.status.length > 0) existing.status = parseInspectionStatus(dto.status, existing.status);
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;

        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(QualityInspectionId id) {
        auto existing = repo.findById(id);
        if (existing is null) return CommandResult(false, "", "Quality inspection not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}

class ManageNonconformancesUseCase {
    private NonconformanceRepository repo;

    this(NonconformanceRepository repo) { this.repo = repo; }

    Nonconformance[] list() { return repo.findAll(); }
    Nonconformance* get_(NonconformanceId id) { return repo.findById(id); }

    CommandResult create(NonconformanceDTO dto) {
        Nonconformance value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.productionOrderId = dto.productionOrderId;
        value.defectCode = dto.defectCode;
        value.defectText = dto.defectText;
        value.severity = parseNonconformanceSeverity(dto.severity);
        value.disposition = dto.disposition;
        value.createdBy = dto.createdBy;

        if (!DMValidator.valid(value)) return CommandResult(false, "", "Invalid nonconformance data");
        repo.save(value);
        return CommandResult(true, value.id, "");
    }

    CommandResult update(NonconformanceDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) return CommandResult(false, "", "Nonconformance not found");

        if (dto.defectText.length > 0) existing.defectText = dto.defectText;
        if (dto.disposition.length > 0) existing.disposition = dto.disposition;
        if (dto.severity.length > 0) existing.severity = parseNonconformanceSeverity(dto.severity, existing.severity);
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;

        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(NonconformanceId id) {
        auto existing = repo.findById(id);
        if (existing is null) return CommandResult(false, "", "Nonconformance not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}

class ManageGenealogyRecordsUseCase {
    private GenealogyRecordRepository repo;

    this(GenealogyRecordRepository repo) { this.repo = repo; }

    GenealogyRecord[] list() { return repo.findAll(); }
    GenealogyRecord* get_(GenealogyRecordId id) { return repo.findById(id); }

    CommandResult create(GenealogyRecordDTO dto) {
        GenealogyRecord value;
        value.id = dto.id;
        value.tenantId = dto.tenantId;
        value.productionOrderId = dto.productionOrderId;
        value.parentSerial = dto.parentSerial;
        value.childSerial = dto.childSerial;
        value.componentMaterialId = dto.componentMaterialId;
        value.assembledAt = dto.assembledAt;
        value.createdBy = dto.createdBy;

        if (!DMValidator.valid(value)) return CommandResult(false, "", "Invalid genealogy record data");
        repo.save(value);
        return CommandResult(true, value.id, "");
    }

    CommandResult update(GenealogyRecordDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) return CommandResult(false, "", "Genealogy record not found");

        if (dto.parentSerial.length > 0) existing.parentSerial = dto.parentSerial;
        if (dto.childSerial.length > 0) existing.childSerial = dto.childSerial;
        if (dto.componentMaterialId.length > 0) existing.componentMaterialId = dto.componentMaterialId;
        if (dto.assembledAt.length > 0) existing.assembledAt = dto.assembledAt;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;

        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(GenealogyRecordId id) {
        auto existing = repo.findById(id);
        if (existing is null) return CommandResult(false, "", "Genealogy record not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
