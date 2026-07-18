/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.ewm.domain.services.validator;

import uim.platform.ewm.domain.entities.bill_of_material;
import uim.platform.ewm.domain.entities.change_request;
import uim.platform.ewm.domain.entities.collaboration;
import uim.platform.ewm.domain.entities.document;
import uim.platform.ewm.domain.entities.product;
import uim.platform.ewm.domain.entities.product_structure;
import uim.platform.ewm.domain.entities.recipe;
import uim.platform.ewm.domain.entities.specification;

@safe:

struct EwmValidator {
    static bool hasIdentity(string id, string tenantId, string name) {
        return id.length > 0 && tenantId.length > 0 && name.length > 0;
    }

    static bool isValidProduct(ref Product value) {
        return hasIdentity(value.id, value.tenantId, value.name);
    }

    static bool isValidBillOfMaterial(ref BillOfMaterial value) {
        return hasIdentity(value.id, value.tenantId, value.name) && value.warehouseId.length > 0;
    }

    static bool isValidChangeRequest(ref ChangeRequest value) {
        return hasIdentity(value.id, value.tenantId, value.title) && value.warehouseId.length > 0;
    }

    static bool isValidDocument(ref Document value) {
        return hasIdentity(value.id, value.tenantId, value.name) && value.warehouseId.length > 0;
    }

    static bool isValidSpecification(ref Specification value) {
        return hasIdentity(value.id, value.tenantId, value.name) && value.warehouseId.length > 0;
    }

    static bool isValidRecipe(ref Recipe value) {
        return hasIdentity(value.id, value.tenantId, value.name) && value.warehouseId.length > 0;
    }

    static bool isValidCollaboration(ref Collaboration value) {
        return hasIdentity(value.id, value.tenantId, value.title) && value.warehouseId.length > 0;
    }

    static bool isValidProductStructure(ref ProductStructure value) {
        return hasIdentity(value.id, value.tenantId, value.name) && value.warehouseId.length > 0;
    }
}