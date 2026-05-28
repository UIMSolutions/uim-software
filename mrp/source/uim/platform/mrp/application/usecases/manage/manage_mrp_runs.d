module uim.platform.mrp.application.usecases.manage.manage_mrp_runs;

import uim.platform.mrp;

mixin(ShowModule!());

@safe:

class ManageMrpRunsUseCase : UIMUseCase {
    private MrpRunRepository mrpRunRepo;
    private ProcurementProposalRepository proposalRepo;
    private MaterialRepository materialRepo;
    private BillOfMaterialRepository bomRepo;
    private InventoryPositionRepository inventoryRepo;

    this(
        MrpRunRepository mrpRunRepo,
        ProcurementProposalRepository proposalRepo,
        MaterialRepository materialRepo,
        BillOfMaterialRepository bomRepo,
        InventoryPositionRepository inventoryRepo
    ) {
        this.mrpRunRepo = mrpRunRepo;
        this.proposalRepo = proposalRepo;
        this.materialRepo = materialRepo;
        this.bomRepo = bomRepo;
        this.inventoryRepo = inventoryRepo;
    }

    MrpRun* get_(MrpRunId id) { return mrpRunRepo.findById(id); }
    MrpRun[] list() { return mrpRunRepo.findAll(); }
    MrpRun[] listByPlant(PlantId plantId) { return mrpRunRepo.findByPlant(plantId); }

    CommandResult create(MrpRunDTO dto) {
        import std.conv : to;

        MrpRun run;
        run.id = dto.id;
        run.tenantId = dto.tenantId;
        run.plantId = dto.plantId;
        run.name = dto.name;
        run.description = dto.description;
        run.planningDate = dto.planningDate;
        run.horizonDays = dto.horizonDays;
        run.includeExternalRequirements = dto.includeExternalRequirements;
        run.includeDependentRequirements = dto.includeDependentRequirements;
        run.includeSafetyStock = dto.includeSafetyStock;
        run.mode = parseEnumValue!RunMode(dto.mode, RunMode.regenerative);
        run.executedBy = dto.executedBy;
        run.executedAt = dto.executedAt;
        run.status = RunStatus.running;

        if (!MRPValidator.isValidMrpRun(run))
            return CommandResult(false, "", "Invalid MRP run data");

        auto proposals = executePlanning(run);
        run.generatedProposalCount = proposals.length.to!string;
        run.status = RunStatus.completed;
        mrpRunRepo.save(run);

        foreach (proposal; proposals) {
            proposalRepo.save(proposal);
        }

        return CommandResult(true, dto.id, "");
    }

    CommandResult update(MrpRunDTO dto) {
        auto existing = mrpRunRepo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "MRP run not found");

        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.status.length > 0) existing.status = parseEnumValue!RunStatus(dto.status, existing.status);
        if (dto.modifiedAt.length > 0) existing.modifiedAt = dto.modifiedAt;

        mrpRunRepo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(MrpRunId id) {
        auto existing = mrpRunRepo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "MRP run not found");
        mrpRunRepo.remove(id);
        return CommandResult(true, id, "");
    }

    private ProcurementProposal[] executePlanning(MrpRun run) {
        import std.math : ceil;
        import std.conv : to;

        ProcurementProposal[] results;

        auto allMaterials = materialRepo.findByPlant(run.plantId);
        Material[] materials;
        foreach (m; allMaterials) {
            if (m.tenantId == run.tenantId && m.status == MaterialStatus.active) {
                materials ~= m;
            }
        }

        double[string] grossDemand;
        foreach (m; materials) {
            grossDemand[m.id] = parseNumber(m.independentDemand);
        }

        auto boms = bomRepo.findByPlant(run.plantId);
        foreach (bom; boms) {
            if (bom.tenantId != run.tenantId) {
                continue;
            }
            auto parentDemand = grossDemand.get(bom.parentMaterialId, 0.0);
            if (parentDemand <= 0) {
                continue;
            }

            auto componentQty = parseNumber(bom.componentQuantity);
            auto baseQty = parseNumber(bom.baseQuantity);
            if (baseQty <= 0) {
                baseQty = 1.0;
            }

            auto dependentDemand = parentDemand * (componentQty / baseQty);
            grossDemand[bom.componentMaterialId] = grossDemand.get(bom.componentMaterialId, 0.0) + dependentDemand;
        }

        size_t seq = 0;
        foreach (m; materials) {
            auto inventoryPtr = inventoryRepo.findByMaterialAndPlant(m.id, m.plantId);
            auto onHand = inventoryPtr is null ? 0.0 : parseNumber(inventoryPtr.onHandQuantity);
            auto receipts = inventoryPtr is null ? 0.0 : parseNumber(inventoryPtr.scheduledReceipts);
            auto reserved = inventoryPtr is null ? 0.0 : parseNumber(inventoryPtr.reservedQuantity);
            auto safety = parseNumber(m.safetyStock);

            auto available = onHand + receipts - reserved - safety;
            auto required = grossDemand.get(m.id, 0.0);

            if (required <= available) {
                continue;
            }

            auto shortage = required - available;
            auto lotSize = parseNumber(m.lotSize);
            auto minimumLot = parseNumber(m.minimumLotSize);
            auto plannedQty = calculateLotSize(m.lotSizingProcedure, shortage, lotSize, minimumLot);
            if (plannedQty <= 0) {
                continue;
            }

            ProcurementProposal p;
            p.id = run.id ~ "-" ~ m.id ~ "-" ~ seq.to!string;
            p.tenantId = run.tenantId;
            p.mrpRunId = run.id;
            p.plantId = run.plantId;
            p.materialId = m.id;
            p.proposalType = m.procurementType == ProcurementType.external ? ProposalType.purchaseRequisition : ProposalType.plannedOrder;
            p.status = ProposalStatus.created;
            p.quantity = plannedQty.to!string;
            p.dueDate = run.planningDate;
            p.source = m.procurementType.to!string;
            p.exceptionMessage = "";
            p.createdBy = run.executedBy;
            p.createdAt = run.executedAt;

            results ~= p;
            seq++;
        }

        return results;
    }

    private static double calculateLotSize(LotSizingProcedure procedure, double shortage, double lotSize, double minimumLot) {
        import std.math : ceil;

        if (shortage <= 0) {
            return 0;
        }

        final switch (procedure) {
            case LotSizingProcedure.fixedLotSize:
                if (lotSize <= 0) {
                    return shortage;
                }
                return ceil(shortage / lotSize) * lotSize;
            case LotSizingProcedure.minimumLotSize:
                if (minimumLot <= 0) {
                    return shortage;
                }
                return shortage < minimumLot ? minimumLot : shortage;
            case LotSizingProcedure.periodic:
                return shortage;
            case LotSizingProcedure.optimumLotSize:
                if (minimumLot > shortage) {
                    return minimumLot;
                }
                return shortage;
            case LotSizingProcedure.lotForLot:
                return shortage;
        }
    }

    private static double parseNumber(string value) {
        import std.conv : to;

        if (value.length == 0) {
            return 0;
        }

        try {
            return value.to!double;
        } catch (Exception e) {
            return 0;
        }
    }

    private static T parseEnumValue(T)(string raw, T fallback) {
        import std.conv : to;

        if (raw.length == 0) {
            return fallback;
        }

        try {
            return raw.to!T;
        } catch (Exception e) {
            return fallback;
        }
    }
}
