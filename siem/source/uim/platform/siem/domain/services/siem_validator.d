/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.siem.domain.services.siem_validator;

import uim.platform.siem;

mixin(ShowModule!());

@safe:

struct SiemValidator {
    static bool isValidSecurityEvent(SecurityEvent e) {
        return e.name.length > 0 && e.tenantId.length > 0 && e.timestamp.length > 0;
    }

    static bool isValidAlert(Alert a) {
        return a.name.length > 0 && a.tenantId.length > 0 && a.correlationRuleId.length > 0;
    }

    static bool isValidIncident(Incident i) {
        return i.name.length > 0 && i.tenantId.length > 0;
    }

    static bool isValidCorrelationRule(CorrelationRule r) {
        return r.name.length > 0 && r.tenantId.length > 0 && r.ruleExpression.length > 0;
    }

    static bool isValidAsset(Asset a) {
        return a.name.length > 0 && a.tenantId.length > 0 && a.ipAddress.length > 0;
    }

    static bool isValidThreatIndicator(ThreatIndicator t) {
        return t.name.length > 0 && t.tenantId.length > 0 && t.value.length > 0;
    }
}
