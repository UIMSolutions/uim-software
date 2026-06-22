module uim.platform.ppm.domain.entities.project;

import uim.platform.ppm.domain.types;

@safe:

struct Project {
    ProjectId id;
    TenantId tenantId;
    ProgramId programId;
    string name;
    string description;
    string projectType;
    string status = "planned";
    string startDate;
    string endDate;
    string projectManager;
    string budgetAmount;
    string currency;
    UserId createdBy;
    UserId modifiedBy;
    string createdAt;
    string modifiedAt;
}
