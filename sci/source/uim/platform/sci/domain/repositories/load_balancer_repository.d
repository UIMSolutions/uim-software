/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.sci.domain.repositories.load_balancer_repository;

import uim.platform.sci;

mixin(ShowModule!());

@safe:

interface LoadBalancerRepository {
    LoadBalancer[] findAll();
    LoadBalancer* findById(LoadBalancerId id);
    LoadBalancer[] findByTenant(TenantId tenantId);
    LoadBalancer[] findByStatus(LoadBalancerStatus status);
    LoadBalancer[] findByAlgorithm(LoadBalancerAlgorithm algorithm);
    void save(LoadBalancer loadBalancer);
    void update(LoadBalancer loadBalancer);
    void remove(LoadBalancerId id);
}
