/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.gtt.domain.services.tracking_validator;

import uim.platform.gtt;

mixin(ShowModule!());

@safe:

struct TrackingValidator {
    static bool isValidShipment(Shipment s) {
        return s.name.length > 0 && s.shipmentNumber.length > 0 && s.carrierName.length > 0 && s.tenantId.length > 0;
    }

    static bool isValidDelivery(Delivery d) {
        return d.name.length > 0 && d.deliveryNumber.length > 0 && d.tenantId.length > 0;
    }

    static bool isValidPurchaseOrder(PurchaseOrder po) {
        return po.name.length > 0 && po.orderNumber.length > 0 && po.supplierId.length > 0 && po.tenantId.length > 0;
    }

    static bool isValidSalesOrder(SalesOrder so) {
        return so.name.length > 0 && so.orderNumber.length > 0 && so.customerId.length > 0 && so.tenantId.length > 0;
    }

    static bool isValidTrackingEvent(TrackingEvent te) {
        return te.trackedObjectId.length > 0 && te.trackedObjectType.length > 0 && te.tenantId.length > 0;
    }

    static bool isValidTrackedProcess(TrackedProcess tp) {
        return tp.name.length > 0 && tp.trackingModelId.length > 0 && tp.tenantId.length > 0;
    }

    static bool isValidLocation(Location l) {
        return l.name.length > 0 && l.country.length > 0 && l.tenantId.length > 0;
    }

    static bool isValidTrackingModel(TrackingModel tm) {
        return tm.name.length > 0 && tm.trackedObjectType.length > 0 && tm.tenantId.length > 0;
    }
}
