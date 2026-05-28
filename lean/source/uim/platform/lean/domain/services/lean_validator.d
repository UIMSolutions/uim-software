/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.lean.domain.services.lean_validator;

import uim.platform.lean;

mixin(ShowModule!());

@safe:

struct LeanValidator {
    static bool isValidObjective(ref Objective o) {
        return o.id.length > 0 && o.name.length > 0 && o.tenantId.length > 0;
    }

    static bool isValidPlatform(ref LeanPlatform p) {
        return p.id.length > 0 && p.name.length > 0 && p.tenantId.length > 0;
    }

    static bool isValidInitiative(ref Initiative i) {
        return i.id.length > 0 && i.name.length > 0 && i.tenantId.length > 0;
    }

    static bool isValidOrganization(ref Organization o) {
        return o.id.length > 0 && o.name.length > 0 && o.tenantId.length > 0;
    }

    static bool isValidBusinessCapability(ref BusinessCapability bc) {
        return bc.id.length > 0 && bc.name.length > 0 && bc.tenantId.length > 0;
    }

    static bool isValidBusinessContext(ref BusinessContext bc) {
        return bc.id.length > 0 && bc.name.length > 0 && bc.tenantId.length > 0;
    }

    static bool isValidDataObject(ref DataObject d) {
        return d.id.length > 0 && d.name.length > 0 && d.tenantId.length > 0;
    }

    static bool isValidLeanApplication(ref LeanApplication a) {
        return a.id.length > 0 && a.name.length > 0 && a.tenantId.length > 0;
    }

    static bool isValidAppInterface(ref AppInterface ai) {
        return ai.id.length > 0 && ai.name.length > 0 && ai.tenantId.length > 0
            && ai.sourceApplicationId.length > 0 && ai.targetApplicationId.length > 0;
    }

    static bool isValidProvider(ref Provider p) {
        return p.id.length > 0 && p.name.length > 0 && p.tenantId.length > 0;
    }

    static bool isValidITComponent(ref ITComponent c) {
        return c.id.length > 0 && c.name.length > 0 && c.tenantId.length > 0;
    }

    static bool isValidTechCategory(ref TechCategory tc) {
        return tc.id.length > 0 && tc.name.length > 0 && tc.tenantId.length > 0;
    }
}
