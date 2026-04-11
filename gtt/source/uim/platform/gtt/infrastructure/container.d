/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.gtt.infrastructure.container;

import uim.platform.gtt;

mixin(ShowModule!());

@safe:

struct Container {
    ManageShipmentsUseCase manageShipmentsUseCase;
    ManageDeliveriesUseCase manageDeliveriesUseCase;
    ManagePurchaseOrdersUseCase managePurchaseOrdersUseCase;
    ManageSalesOrdersUseCase manageSalesOrdersUseCase;
    ManageTrackingEventsUseCase manageTrackingEventsUseCase;
    ManageTrackedProcessesUseCase manageTrackedProcessesUseCase;
    ManageLocationsUseCase manageLocationsUseCase;
    ManageTrackingModelsUseCase manageTrackingModelsUseCase;

    ShipmentController shipmentController;
    DeliveryController deliveryController;
    PurchaseOrderController purchaseOrderController;
    SalesOrderController salesOrderController;
    TrackingEventController trackingEventController;
    TrackedProcessController trackedProcessController;
    LocationController locationController;
    TrackingModelController trackingModelController;
    HealthController healthController;
}

Container buildContainer(AppConfig config) {
    Container c;

    // Repositories
    auto shipmentRepo = new MemoryShipmentRepository();
    auto deliveryRepo = new MemoryDeliveryRepository();
    auto purchaseOrderRepo = new MemoryPurchaseOrderRepository();
    auto salesOrderRepo = new MemorySalesOrderRepository();
    auto trackingEventRepo = new MemoryTrackingEventRepository();
    auto trackedProcessRepo = new MemoryTrackedProcessRepository();
    auto locationRepo = new MemoryLocationRepository();
    auto trackingModelRepo = new MemoryTrackingModelRepository();

    // Use Cases
    c.manageShipmentsUseCase = new ManageShipmentsUseCase(shipmentRepo);
    c.manageDeliveriesUseCase = new ManageDeliveriesUseCase(deliveryRepo);
    c.managePurchaseOrdersUseCase = new ManagePurchaseOrdersUseCase(purchaseOrderRepo);
    c.manageSalesOrdersUseCase = new ManageSalesOrdersUseCase(salesOrderRepo);
    c.manageTrackingEventsUseCase = new ManageTrackingEventsUseCase(trackingEventRepo);
    c.manageTrackedProcessesUseCase = new ManageTrackedProcessesUseCase(trackedProcessRepo);
    c.manageLocationsUseCase = new ManageLocationsUseCase(locationRepo);
    c.manageTrackingModelsUseCase = new ManageTrackingModelsUseCase(trackingModelRepo);

    // Controllers
    c.shipmentController = new ShipmentController(c.manageShipmentsUseCase);
    c.deliveryController = new DeliveryController(c.manageDeliveriesUseCase);
    c.purchaseOrderController = new PurchaseOrderController(c.managePurchaseOrdersUseCase);
    c.salesOrderController = new SalesOrderController(c.manageSalesOrdersUseCase);
    c.trackingEventController = new TrackingEventController(c.manageTrackingEventsUseCase);
    c.trackedProcessController = new TrackedProcessController(c.manageTrackedProcessesUseCase);
    c.locationController = new LocationController(c.manageLocationsUseCase);
    c.trackingModelController = new TrackingModelController(c.manageTrackingModelsUseCase);
    c.healthController = new HealthController();

    return c;
}
