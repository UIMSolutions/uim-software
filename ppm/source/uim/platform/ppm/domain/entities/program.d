module uim.platform.ppm.domain.entities.program;

import uim.platform.ppm.domain.types;

@safe:

struct Program {
    ProgramId id;
    TenantId tenantId;
    PortfolioId portfolioId;
    string name;
    string objective;
    string status = "draft";
    string manager;
    string startDate;
    string endDate;
    UserId createdBy;
    UserId modifiedBy;
    string createdAt;
    string modifiedAt;
}
