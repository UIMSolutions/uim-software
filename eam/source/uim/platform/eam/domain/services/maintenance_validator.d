/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.eam.domain.services.maintenance_validator;

import uim.platform.eam;

mixin(ShowModule!());

@safe:

struct MaintenanceValidator {
    static bool isValidEquipment(Equipment e) {
        return e.name.length > 0 && e.equipmentNumber.length > 0 && e.tenantId.length > 0;
    }

    static bool isValidFunctionalLocation(FunctionalLocation fl) {
        return fl.name.length > 0 && fl.locationLabel.length > 0 && fl.tenantId.length > 0;
    }

    static bool isValidMaintenanceOrder(MaintenanceOrder o) {
        return o.name.length > 0 && o.orderNumber.length > 0 && o.equipmentId.length > 0 && o.tenantId.length > 0;
    }

    static bool isValidMaintenanceNotification(MaintenanceNotification n) {
        return n.name.length > 0 && n.notificationNumber.length > 0 && n.tenantId.length > 0;
    }

    static bool isValidMaintenancePlan(MaintenancePlan p) {
        return p.name.length > 0 && p.cycleLength.length > 0 && p.cycleUnit.length > 0 && p.tenantId.length > 0;
    }

    static bool isValidWorkCenter(WorkCenter wc) {
        return wc.name.length > 0 && wc.tenantId.length > 0;
    }

    static bool isValidMaterialBOM(MaterialBOM bom) {
        return bom.name.length > 0 && bom.materialNumber.length > 0 && bom.equipmentId.length > 0 && bom.tenantId.length > 0;
    }

    static bool isValidMaintenanceItem(MaintenanceItem mi) {
        return mi.name.length > 0 && mi.maintenancePlanId.length > 0 && mi.tenantId.length > 0;
    }
}
