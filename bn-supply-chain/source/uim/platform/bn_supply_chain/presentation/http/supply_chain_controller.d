module uim.platform.bn_supply_chain.presentation.http.supply_chain_controller;

import vibe.http.router : URLRouter;
import vibe.http.server : HTTPServerRequest, HTTPServerResponse;
import uim.platform.bn_supply_chain.application.usecases.supply_chain_service;

class SupplyChainApiController {
    private SupplyChainService service;

    this(SupplyChainService service) {
        this.service = service;
    }

    void registerRoutes(URLRouter router) {
        router.get("/api/v1/partners", &listPartnersHandler);
        router.get("/api/v1/orders", &listOrdersHandler);
        router.get("/api/v1/shipments", &listShipmentsHandler);
        router.get("/api/v1/ship-notices", &listShipNoticesHandler);
        router.get("/api/v1/invoices", &listInvoicesHandler);
        router.get("/api/v1/alerts", &listAlertsHandler);
    }

    void listPartnersHandler(HTTPServerRequest req, HTTPServerResponse res) {
        res.writeJsonBody(service.listPartners(), 200);
    }

    void listOrdersHandler(HTTPServerRequest req, HTTPServerResponse res) {
        res.writeJsonBody(service.listOrders(), 200);
    }

    void listShipmentsHandler(HTTPServerRequest req, HTTPServerResponse res) {
        res.writeJsonBody(service.listShipments(), 200);
    }

    void listShipNoticesHandler(HTTPServerRequest req, HTTPServerResponse res) {
        res.writeJsonBody(service.listShipNotices(), 200);
    }

    void listInvoicesHandler(HTTPServerRequest req, HTTPServerResponse res) {
        res.writeJsonBody(service.listInvoices(), 200);
    }

    void listAlertsHandler(HTTPServerRequest req, HTTPServerResponse res) {
        res.writeJsonBody(service.listAlerts(), 200);
    }
}
