module uim.platform.mii.domain.services.validator;

import uim.platform.mii.domain.entities.bill_of_material;
import uim.platform.mii.domain.entities.change_request;
import uim.platform.mii.domain.entities.collaboration;
import uim.platform.mii.domain.entities.document;
import uim.platform.mii.domain.entities.product;
import uim.platform.mii.domain.entities.product_structure;
import uim.platform.mii.domain.entities.recipe;
import uim.platform.mii.domain.entities.specification;

@safe:

struct MiiValidator {
    static bool hasIdentity(string id, string tenantId, string name) {
        return id.length > 0 && tenantId.length > 0 && name.length > 0;
    }

    static bool isValidProduct(ref Product value) {
        return hasIdentity(value.id, value.tenantId, value.name);
    }

    static bool isValidBillOfMaterial(ref BillOfMaterial value) {
        return hasIdentity(value.id, value.tenantId, value.name) && value.messageId.length > 0;
    }

    static bool isValidChangeRequest(ref ChangeRequest value) {
        return hasIdentity(value.id, value.tenantId, value.title) && value.messageId.length > 0;
    }

    static bool isValidDocument(ref Document value) {
        return hasIdentity(value.id, value.tenantId, value.name) && value.messageId.length > 0;
    }

    static bool isValidSpecification(ref Specification value) {
        return hasIdentity(value.id, value.tenantId, value.name) && value.messageId.length > 0;
    }

    static bool isValidRecipe(ref Recipe value) {
        return hasIdentity(value.id, value.tenantId, value.name) && value.messageId.length > 0;
    }

    static bool isValidCollaboration(ref Collaboration value) {
        return hasIdentity(value.id, value.tenantId, value.title) && value.messageId.length > 0;
    }

    static bool isValidProductStructure(ref ProductStructure value) {
        return hasIdentity(value.id, value.tenantId, value.name) && value.messageId.length > 0;
    }
}