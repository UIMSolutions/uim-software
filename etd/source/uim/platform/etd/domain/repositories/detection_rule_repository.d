/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.etd.domain.repositories.detection_rules;

import uim.platform.etd.domain.entities.detection_rule;

@safe:

interface DetectionRuleRepository {
    DetectionRule[] list();
    const(DetectionRule)* get_(string id);
    bool create(DetectionRule item);
    bool update(DetectionRule item);
    bool remove(string id);
}
