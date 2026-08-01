module uim.platform.pp.application.dto;

@safe:

struct CommandResult {
    bool success;
    string id;
    string error;
}

struct PPObjectDTO {
    string id;
    string objectType;
    string tenantId;
    string plantId;
    string materialId;
    string orderId;
    string name;
    string status;
    string description;
    string startDate;
    string endDate;
    string quantity;
    string uom;
    string priority;
    string createdBy;
    string modifiedBy;
    string[string] attributes;
}

struct MRPExecutionDTO {
    string plantId;
    string materialId;
    string runMode;
    string horizonDays;
    string initiatedBy;
}
