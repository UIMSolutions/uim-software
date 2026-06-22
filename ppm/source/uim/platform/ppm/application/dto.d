module uim.platform.ppm.application.dto;

@safe:

struct CommandResult {
    bool success;
    string id;
    string error;
}

struct PortfolioDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string strategicTheme;
    string status;
    string planningHorizon;
    string owner;
    string budgetAmount;
    string currency;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct InitiativeDTO {
    string id;
    string tenantId;
    string portfolioId;
    string title;
    string description;
    string category;
    string priority;
    string status;
    string sponsor;
    string expectedBenefits;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct ProgramDTO {
    string id;
    string tenantId;
    string portfolioId;
    string name;
    string objective;
    string status;
    string manager;
    string startDate;
    string endDate;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct ProjectDTO {
    string id;
    string tenantId;
    string programId;
    string name;
    string description;
    string projectType;
    string status;
    string startDate;
    string endDate;
    string projectManager;
    string budgetAmount;
    string currency;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct DemandDTO {
    string id;
    string tenantId;
    string portfolioId;
    string title;
    string description;
    string source;
    string businessValue;
    string priority;
    string status;
    string requestedBy;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct ResourceRequestDTO {
    string id;
    string tenantId;
    string projectId;
    string role;
    string quantity;
    string allocationPercent;
    string startDate;
    string endDate;
    string status;
    string requestedBy;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
