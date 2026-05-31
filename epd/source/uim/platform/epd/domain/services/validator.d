module uim.platform.epd.domain.services.validator;

import uim.platform.epd.domain.entities.bill_of_material;
import uim.platform.epd.domain.entities.change_request;
import uim.platform.epd.domain.entities.collaboration;
import uim.platform.epd.domain.entities.document;
import uim.platform.epd.domain.entities.product;
import uim.platform.epd.domain.entities.product_structure;
import uim.platform.epd.domain.entities.recipe;
import uim.platform.epd.domain.entities.specification;

@safe:

struct EpdValidator {
    static bool hasIdentity(string id, string tenantId, string name) {
        return id.length > 0 && tenantId.length > 0 && name.length > 0;
    }

    static bool isValidProduct(ref Product value) {
        return hasIdentity(value.id, value.tenantId, value.name);
    }

    static bool isValidBillOfMaterial(ref BillOfMaterial value) {
        return hasIdentity(value.id, value.tenantId, value.name) && value.productId.length > 0;
    }

    static bool isValidChangeRequest(ref ChangeRequest value) {
        return hasIdentity(value.id, value.tenantId, value.title) && value.productId.length > 0;
    }

    static bool isValidDocument(ref Document value) {
        return hasIdentity(value.id, value.tenantId, value.name) && value.productId.length > 0;
    }

    static bool isValidSpecification(ref Specification value) {
        return hasIdentity(value.id, value.tenantId, value.name) && value.productId.length > 0;
    }

    static bool isValidRecipe(ref Recipe value) {
        return hasIdentity(value.id, value.tenantId, value.name) && value.productId.length > 0;
    }

    static bool isValidCollaboration(ref Collaboration value) {
        return hasIdentity(value.id, value.tenantId, value.title) && value.productId.length > 0;
    }

    static bool isValidProductStructure(ref ProductStructure value) {
        return hasIdentity(value.id, value.tenantId, value.name) && value.productId.length > 0;
    }
}