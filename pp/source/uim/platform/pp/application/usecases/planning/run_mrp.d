module uim.platform.pp.application.usecases.planning.run_mrp;

import std.conv : to;
import std.datetime : Clock;
import uim.platform.pp.application.dto : CommandResult, MRPExecutionDTO, PPObjectDTO;
import uim.platform.pp.application.usecases.manage.manage_pp_objects : ManagePPObjectsUseCase;

@safe:

class RunMRPUseCase {
    private ManagePPObjectsUseCase manageUseCase;

    this(ManagePPObjectsUseCase manageUseCase) {
        this.manageUseCase = manageUseCase;
    }

    CommandResult execute(MRPExecutionDTO dto) {
        PPObjectDTO run;
        run.objectType = "mrp-runs";
        run.plantId = dto.plantId;
        run.materialId = dto.materialId;
        run.name = "MRP-" ~ Clock.currTime().toISOExtString();
        run.status = "completed";
        run.description = "mode=" ~ (dto.runMode.length ? dto.runMode : "net-change") ~ ", horizonDays=" ~ (dto.horizonDays.length ? dto.horizonDays : "30");
        run.createdBy = dto.initiatedBy.length ? dto.initiatedBy : "system";

        auto runResult = manageUseCase.create(run);
        if (!runResult.success) {
            return runResult;
        }

        PPObjectDTO plannedOrder;
        plannedOrder.objectType = "planned-orders";
        plannedOrder.plantId = dto.plantId;
        plannedOrder.materialId = dto.materialId;
        plannedOrder.orderId = runResult.id;
        plannedOrder.name = "Planned Order for " ~ (dto.materialId.length ? dto.materialId : "GENERIC");
        plannedOrder.status = "created";
        plannedOrder.quantity = "100";
        plannedOrder.uom = "EA";
        plannedOrder.priority = "normal";
        plannedOrder.createdBy = run.createdBy;

        auto poResult = manageUseCase.create(plannedOrder);
        if (!poResult.success) {
            return CommandResult(false, "", "MRP run created but planned-order creation failed: " ~ poResult.error);
        }

        return CommandResult(true, runResult.id, "");
    }
}

unittest {
    import uim.platform.pp.infrastructure.persistence.memory.pp_repository : MemoryPPRepository;
    import uim.platform.pp.application.usecases.manage.manage_pp_objects : ManagePPObjectsUseCase;

    auto repo = new MemoryPPRepository();
    auto manage = new ManagePPObjectsUseCase(repo);
    auto mrp = new RunMRPUseCase(manage);

    auto result = mrp.execute(MRPExecutionDTO("PL01", "MAT-100", "net-change", "14", "planner"));
    assert(result.success);

    auto planned = manage.listByMaterial("planned-orders", "MAT-100");
    assert(planned.length == 1);
}
