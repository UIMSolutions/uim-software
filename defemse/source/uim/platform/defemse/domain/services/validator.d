module uim.platform.defemse.domain.services.validator;

import uim.platform.defemse.domain.entities.contingent;
import uim.platform.defemse.domain.entities.maintenance_task;
import uim.platform.defemse.domain.entities.budget_trigger;
import uim.platform.defemse.domain.entities.offline_sync_record;
import uim.platform.defemse.domain.entities.exercise;
import uim.platform.defemse.domain.entities.mission_plan;
import uim.platform.defemse.domain.entities.readiness_profile;
import uim.platform.defemse.domain.entities.redeployment_order;

@safe:

struct DefemseValidator {
    static bool isValidMissionPlan(ref MissionPlan value) {
        return value.id.length > 0 && value.tenantId.length > 0 && value.name.length > 0;
    }

    static bool isValidExercise(ref Exercise value) {
        return value.id.length > 0 && value.tenantId.length > 0 && value.name.length > 0;
    }

    static bool isValidContingent(ref Contingent value) {
        return value.id.length > 0 && value.tenantId.length > 0 && value.name.length > 0;
    }

    static bool isValidReadinessProfile(ref ReadinessProfile value) {
        return value.id.length > 0 && value.tenantId.length > 0 && value.contingentId.length > 0;
    }

    static bool isValidRedeploymentOrder(ref RedeploymentOrder value) {
        return value.id.length > 0 && value.tenantId.length > 0 && value.contingentId.length > 0;
    }

    static bool isValidMaintenanceTask(ref MaintenanceTask value) {
        return value.id.length > 0 && value.tenantId.length > 0 && value.contingentId.length > 0;
    }

    static bool isValidBudgetTrigger(ref BudgetTrigger value) {
        return value.id.length > 0 && value.tenantId.length > 0 && value.missionPlanId.length > 0;
    }

    static bool isValidOfflineSyncRecord(ref OfflineSyncRecord value) {
        return value.id.length > 0 && value.tenantId.length > 0 && value.recordType.length > 0;
    }
}