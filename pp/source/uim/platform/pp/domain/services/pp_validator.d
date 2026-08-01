module uim.platform.pp.domain.services.pp_validator;

import uim.platform.pp.domain.entities.pp_object : PPObject;

@safe:

struct PPValidator {
    static bool isValid(PPObject value) {
        if (value.objectType.length == 0) {
            return false;
        }
        if (value.name.length == 0 && value.materialId.length == 0) {
            return false;
        }
        return true;
    }
}
