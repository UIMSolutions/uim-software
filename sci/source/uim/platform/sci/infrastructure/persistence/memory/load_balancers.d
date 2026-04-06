/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.sci.infrastructure.persistence.memory.load_balancers;

import uim.platform.sci;

mixin(ShowModule!());

@safe:

class MemoryLoadBalancerRepository : LoadBalancerRepository {
    private LoadBalancer[] store;

    LoadBalancer[] findAll() { return store; }

    LoadBalancer* findById(LoadBalancerId id) {
        foreach (ref e; store)
            if (e.id == id) return &e;
        return null;
    }

    LoadBalancer[] findByTenant(TenantId tenantId) {
        LoadBalancer[] result;
        foreach (ref e; store)
            if (e.tenantId == tenantId) result ~= e;
        return result;
    }

    LoadBalancer[] findByStatus(LoadBalancerStatus status) {
        LoadBalancer[] result;
        foreach (ref e; store)
            if (e.status == status) result ~= e;
        return result;
    }

    LoadBalancer[] findByAlgorithm(LoadBalancerAlgorithm algorithm) {
        LoadBalancer[] result;
        foreach (ref e; store)
            if (e.algorithm == algorithm) result ~= e;
        return result;
    }

    void save(LoadBalancer loadBalancer) { store ~= loadBalancer; }

    void update(LoadBalancer loadBalancer) {
        foreach (ref e; store)
            if (e.id == loadBalancer.id) { e = loadBalancer; return; }
    }

    void remove(LoadBalancerId id) {
        import std.algorithm : remove;
        store = store.remove!(e => e.id == id);
    }
}
