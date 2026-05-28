/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.domain.entities.service_request;

import uim.platform.itil;

mixin(ShowModule!());

@safe:

struct ServiceRequest {
    ServiceRequestId id;
    TenantId tenantId;
    string title;
    string description;
    RecordStatus status = RecordStatus.open;
    Priority priority = Priority.medium;
    string requesterId;
    string requestDate;
    string requiredByDate;
    string resolvedDate;
    string resolverId;
    string assignedTo;
    ITServiceId serviceId;
    string category;
    string resolutionNotes;
    string[] tags;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
