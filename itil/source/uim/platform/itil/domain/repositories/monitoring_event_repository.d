/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.domain.repositories.monitoring_event_repository;

import uim.platform.itil;

mixin(ShowModule!());

@safe:

interface MonitoringEventRepository {
    MonitoringEvent[] findAll();
    MonitoringEvent* findById(MonitoringEventId id);
    MonitoringEvent[] findByTenant(TenantId tenantId);
    MonitoringEvent[] findByStatus(EventStatus eventStatus);
    MonitoringEvent[] findBySeverity(EventSeverity severity);
    MonitoringEvent[] findByService(ITServiceId serviceId);
    MonitoringEvent[] findByCI(ConfigurationItemId ciId);
    void save(MonitoringEvent event);
    void update(MonitoringEvent event);
    void remove(MonitoringEventId id);
}
