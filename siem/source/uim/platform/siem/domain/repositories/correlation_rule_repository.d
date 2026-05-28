/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.siem.domain.repositories.correlation_rule_repository;

import uim.platform.siem;

mixin(ShowModule!());

@safe:

interface CorrelationRuleRepository {
    CorrelationRule[] findAll();
    CorrelationRule* findById(CorrelationRuleId id);
    CorrelationRule[] findByTenant(TenantId tenantId);
    CorrelationRule[] findByStatus(RuleStatus status);
    CorrelationRule[] findByType(RuleType ruleType);
    void save(CorrelationRule rule);
    void update(CorrelationRule rule);
    void remove(CorrelationRuleId id);
}
