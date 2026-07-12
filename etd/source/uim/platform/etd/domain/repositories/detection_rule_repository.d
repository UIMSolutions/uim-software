module uim.platform.etd.domain.repositories.detection_rule_repository;

import uim.platform.etd.domain.entities.detection_rule;

@safe:

interface DetectionRuleRepository {
    DetectionRule[] list();
    const(DetectionRule)* get_(string id);
    bool create(DetectionRule item);
    bool update(DetectionRule item);
    bool remove(string id);
}
