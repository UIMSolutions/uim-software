module uim.platform.mrp.domain.services.mrp_validator;

import uim.platform.mrp;

mixin(ShowModule!());

@safe:

struct MRPValidator {
    static bool isValidMaterial(Material m) {
        return m.name.length > 0 && m.materialNumber.length > 0 && m.tenantId.length > 0 && m.plantId.length > 0;
    }

    static bool isValidPlant(Plant p) {
        return p.name.length > 0 && p.plantCode.length > 0 && p.tenantId.length > 0;
    }

    static bool isValidBillOfMaterial(BillOfMaterial b) {
        return b.parentMaterialId.length > 0 && b.componentMaterialId.length > 0 && b.componentQuantity.length > 0 && b.tenantId.length > 0;
    }

    static bool isValidInventoryPosition(InventoryPosition i) {
        return i.materialId.length > 0 && i.plantId.length > 0 && i.tenantId.length > 0;
    }

    static bool isValidMrpRun(MrpRun r) {
        return r.id.length > 0 && r.plantId.length > 0 && r.tenantId.length > 0;
    }

    static bool isValidProcurementProposal(ProcurementProposal p) {
        return p.materialId.length > 0 && p.mrpRunId.length > 0 && p.quantity.length > 0 && p.tenantId.length > 0;
    }
}
