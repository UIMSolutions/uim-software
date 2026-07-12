module uim.platform.etd.domain.services.etd_validator;

import uim.platform.etd.domain.entities.detection_rule : DetectionRule;
import uim.platform.etd.domain.entities.incident : Incident;
import uim.platform.etd.domain.entities.threat_indicator : ThreatIndicator;

@safe:

struct EtdValidator {
    static bool isValidIncident(Incident value) {
        return value.title.length > 0 && value.severity.length > 0;
    }

    static bool isValidThreatIndicator(ThreatIndicator value) {
        return value.indicatorType.length > 0 && value.indicatorValue.length > 0;
    }

    static bool isValidDetectionRule(DetectionRule value) {
        return value.name.length > 0 && value.queryPattern.length > 0;
    }
}
