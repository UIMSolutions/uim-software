module uim.platform.ecm.domain.services.ecm_validator;

import uim.platform.ecm.domain.entities.ecm_object : EcmObject;

@safe:

struct EcmValidator {
    static bool isValid(EcmObject value) {
        if (value.objectType.length == 0) {
            return false;
        }
        if (value.name.length == 0 && value.title.length == 0) {
            return false;
        }
        return true;
    }
}
