/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.gtt.domain.entities.tracking_model;

import uim.platform.gtt;

mixin(ShowModule!());

@safe:

struct TrackingModel {
    TrackingModelId id;
    TenantId tenantId;
    string name;
    string description;
    ModelStatus status = ModelStatus.draft;
    string trackedObjectType;
    string expectedEvents;
    string milestones;
    string correlationRules;
    string exceptionRules;
    string version_;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
