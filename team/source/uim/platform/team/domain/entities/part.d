module uim.platform.team.domain.entities.part;

import uim.platform.team.domain.types;

@safe:

struct Part {
    PartId id;
    TenantId tenantId;
    string number;
    string name;
    string description;
    string revision;
    PartLifecycleState lifecycleState = PartLifecycleState.inWork;
    string owningOrganization;
    string responsibleEngineer;
    string materialClass;
    string unitOfMeasure;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
