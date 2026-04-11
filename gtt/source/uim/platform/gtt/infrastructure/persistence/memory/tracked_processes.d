/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.gtt.infrastructure.persistence.memory.tracked_processes;

import uim.platform.gtt;

mixin(ShowModule!());

@safe:

class MemoryTrackedProcessRepository : TrackedProcessRepository {
    private TrackedProcess[] store;

    TrackedProcess[] findAll() { return store; }

    TrackedProcess* findById(TrackedProcessId id) {
        foreach (ref e; store)
            if (e.id == id) return &e;
        return null;
    }

    TrackedProcess[] findByTenant(TenantId tenantId) {
        TrackedProcess[] result;
        foreach (ref e; store)
            if (e.tenantId == tenantId) result ~= e;
        return result;
    }

    TrackedProcess[] findByStatus(ProcessStatus status) {
        TrackedProcess[] result;
        foreach (ref e; store)
            if (e.status == status) result ~= e;
        return result;
    }

    TrackedProcess[] findByProcessType(ProcessType processType) {
        TrackedProcess[] result;
        foreach (ref e; store)
            if (e.processType == processType) result ~= e;
        return result;
    }

    void save(TrackedProcess process) { store ~= process; }

    void update(TrackedProcess process) {
        foreach (ref e; store)
            if (e.id == process.id) { e = process; return; }
    }

    void remove(TrackedProcessId id) {
        import std.algorithm : remove;
        store = store.remove!(e => e.id == id);
    }
}
