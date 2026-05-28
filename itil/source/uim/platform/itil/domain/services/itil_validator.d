/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.domain.services.itil_validator;

import uim.platform.itil;

mixin(ShowModule!());

@safe:

struct ITILValidator {
    static bool isValidITService(ref ITService s) {
        return s.id.length > 0 && s.name.length > 0 && s.tenantId.length > 0;
    }
    static bool isValidServiceRequest(ref ServiceRequest r) {
        return r.id.length > 0 && r.title.length > 0 && r.tenantId.length > 0;
    }
    static bool isValidIncident(ref Incident i) {
        return i.id.length > 0 && i.title.length > 0 && i.tenantId.length > 0;
    }
    static bool isValidProblem(ref Problem p) {
        return p.id.length > 0 && p.title.length > 0 && p.tenantId.length > 0;
    }
    static bool isValidChangeRecord(ref ChangeRecord c) {
        return c.id.length > 0 && c.title.length > 0 && c.tenantId.length > 0;
    }
    static bool isValidConfigurationItem(ref ConfigurationItem ci) {
        return ci.id.length > 0 && ci.name.length > 0 && ci.tenantId.length > 0;
    }
    static bool isValidSLA(ref ServiceLevelAgreement sla) {
        return sla.id.length > 0 && sla.name.length > 0 && sla.tenantId.length > 0;
    }
    static bool isValidKnowledgeArticle(ref KnowledgeArticle ka) {
        return ka.id.length > 0 && ka.title.length > 0 && ka.tenantId.length > 0;
    }
    static bool isValidReleaseRecord(ref ReleaseRecord r) {
        return r.id.length > 0 && r.name.length > 0 && r.tenantId.length > 0;
    }
    static bool isValidMonitoringEvent(ref MonitoringEvent e) {
        return e.id.length > 0 && e.title.length > 0 && e.tenantId.length > 0;
    }
    static bool isValidImprovementItem(ref ImprovementItem i) {
        return i.id.length > 0 && i.title.length > 0 && i.tenantId.length > 0;
    }
    static bool isValidITAsset(ref ITAsset a) {
        return a.id.length > 0 && a.name.length > 0 && a.tenantId.length > 0;
    }
}
