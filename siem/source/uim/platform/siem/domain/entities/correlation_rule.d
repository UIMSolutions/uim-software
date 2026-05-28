/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.siem.domain.entities.correlation_rule;

import uim.platform.siem;

mixin(ShowModule!());

@safe:

struct CorrelationRule {
    CorrelationRuleId id;
    TenantId tenantId;
    string name;
    string description;
    RuleType ruleType = RuleType.threshold;
    RuleStatus status = RuleStatus.enabled;
    string ruleExpression;
    string conditionField;
    string conditionOperator;
    string conditionValue;
    string timeWindowSeconds;
    string threshold;
    string aggregationField;
    string severity;
    string alertName;
    string mitreTactic;
    string mitreTechnique;
    string author;
    string version_;
    string tags;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
