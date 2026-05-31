module uim.platform.ps.domain.services.ps_validator;

import uim.platform.ps;

mixin(ShowModule!());

@safe:

class PSValidator {
    static bool isValidProject(Project p) {
        return p.id.length > 0 && p.tenantId.length > 0 && p.name.length > 0 && p.projectDefinition.length > 0;
    }

    static bool isValidWBSElement(WBSElement e) {
        return e.id.length > 0 && e.tenantId.length > 0 && e.projectId.length > 0 && e.wbsCode.length > 0;
    }

    static bool isValidNetworkActivity(NetworkActivity a) {
        return a.id.length > 0 && a.tenantId.length > 0 && a.projectId.length > 0 && a.activityNumber.length > 0;
    }

    static bool isValidMilestone(Milestone m) {
        return m.id.length > 0 && m.tenantId.length > 0 && m.projectId.length > 0 && m.name.length > 0;
    }

    static bool isValidProjectCost(ProjectCost c) {
        return c.id.length > 0 && c.tenantId.length > 0 && c.projectId.length > 0;
    }

    static bool isValidProjectBudget(ProjectBudget b) {
        return b.id.length > 0 && b.tenantId.length > 0 && b.projectId.length > 0;
    }
}
