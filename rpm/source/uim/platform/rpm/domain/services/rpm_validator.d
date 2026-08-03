module uim.platform.rpm.domain.services.rpm_validator;

import uim.platform.rpm.domain.entities.rpm_object : RpmObject;

@safe:

struct RpmValidator {
    static bool isValid(in RpmObject value) {
        if (!value.objectType.length) {
            return false;
        }

        if (!value.technicalName.length && !value.businessName.length) {
            return false;
        }

        if (value.quantity < 0) {
            return false;
        }

        return true;
    }
}

unittest {
    RpmObject ok;
    ok.objectType = "packaging-materials";
    ok.technicalName = "PALLET-120x80";
    ok.quantity = 0;
    assert(RpmValidator.isValid(ok));

    RpmObject bad;
    bad.objectType = "";
    bad.technicalName = "X";
    assert(!RpmValidator.isValid(bad));
}
