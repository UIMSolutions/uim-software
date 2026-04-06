/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.sci.domain.entities.load_balancer;

import uim.platform.sci;

mixin(ShowModule!());

@safe:

struct LoadBalancer {
    LoadBalancerId id;
    TenantId tenantId;
    string name;
    string description;
    LoadBalancerStatus status = LoadBalancerStatus.active;
    LoadBalancerAlgorithm algorithm = LoadBalancerAlgorithm.roundRobin;
    string vipAddress;
    string vipSubnetId;
    string protocol;
    string protocolPort;
    string healthMonitorUrl;
    string members;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
