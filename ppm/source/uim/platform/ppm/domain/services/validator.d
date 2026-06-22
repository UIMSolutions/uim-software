module uim.platform.ppm.domain.services.validator;

import uim.platform.ppm.domain.entities.demand;
import uim.platform.ppm.domain.entities.initiative;
import uim.platform.ppm.domain.entities.portfolio;
import uim.platform.ppm.domain.entities.program;
import uim.platform.ppm.domain.entities.project;
import uim.platform.ppm.domain.entities.resource_request;

@safe:

struct PpmValidator {
    static bool hasIdentity(string id, string tenantId, string name) {
        return id.length > 0 && tenantId.length > 0 && name.length > 0;
    }

    static bool isValidPortfolio(ref Portfolio value) {
        return hasIdentity(value.id, value.tenantId, value.name);
    }

    static bool isValidInitiative(ref Initiative value) {
        return hasIdentity(value.id, value.tenantId, value.title) && value.portfolioId.length > 0;
    }

    static bool isValidProgram(ref Program value) {
        return hasIdentity(value.id, value.tenantId, value.name) && value.portfolioId.length > 0;
    }

    static bool isValidProject(ref Project value) {
        return hasIdentity(value.id, value.tenantId, value.name) && value.programId.length > 0;
    }

    static bool isValidDemand(ref Demand value) {
        return hasIdentity(value.id, value.tenantId, value.title) && value.portfolioId.length > 0;
    }

    static bool isValidResourceRequest(ref ResourceRequest value) {
        return hasIdentity(value.id, value.tenantId, value.role) && value.projectId.length > 0;
    }
}
