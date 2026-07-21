module uim.platform.defense.domain.services.validator;

import uim.platform.defense.domain.entities.contingent;
import uim.platform.defense.domain.entities.maintenance_task;
import uim.platform.defense.domain.entities.budget_trigger;
import uim.platform.defense.domain.entities.offline_sync_record;
import uim.platform.defense.domain.entities.exercise;
import uim.platform.defense.domain.entities.mission_plan;
import uim.platform.defense.domain.entities.readiness_profile;
import uim.platform.defense.domain.entities.redeployment_order;

@safe:

struct defenseValidator {
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