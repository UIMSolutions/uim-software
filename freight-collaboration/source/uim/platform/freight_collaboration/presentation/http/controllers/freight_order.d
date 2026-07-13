module uim.platform.freight_collaboration.presentation.http.controllers.freight_order;

import std.conv : to;
import uim.platform.freight_collaboration;

@safe:

class FreightOrderController : SAPController {
    private ManageFreightOrdersUseCase useCase;

    this(ManageFreightOrdersUseCase useCase) {
        this.useCase = useCase;
    }

    override void registerRoutes(URLRouter router) {
        router.get("/api/v1/freight-collaboration/freight-orders", &handleList);
        router.get("/api/v1/freight-collaboration/freight-orders/*", &handleGet);
        router.post("/api/v1/freight-collaboration/freight-orders", &handleCreate);
        router.put("/api/v1/freight-collaboration/freight-orders/*", &handleUpdate);
        router.delete_("/api/v1/freight-collaboration/freight-orders/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto items = useCase.list();
        auto arr = Json.emptyArray;
        foreach (item; items) arr ~= freightOrderToJson(item);

        auto body = Json.emptyObject;
        body["count"] = Json(cast(long) items.length);
        body["resources"] = arr;
        writeJsonBody(res, body);
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto item = useCase.get_(id);
        if (item is null) {
            writeError(res, 404, "Freight order not found");
            return;
        }
        writeJsonBody(res, freightOrderToJson(*item));
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        FreightOrderDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = req.headers.get("X-Tenant-Id", "");
        dto.orderNumber = jsonStr(j, "orderNumber");
        dto.shipperId = jsonStr(j, "shipperId");
        dto.carrierId = jsonStr(j, "carrierId");
        dto.transportMode = jsonStr(j, "transportMode");
        dto.status = jsonStr(j, "status");
        dto.originLocation = jsonStr(j, "originLocation");
        dto.destinationLocation = jsonStr(j, "destinationLocation");
        dto.plannedPickup = jsonStr(j, "plannedPickup");
        dto.plannedDelivery = jsonStr(j, "plannedDelivery");
        dto.createdBy = jsonStr(j, "createdBy");

        auto result = useCase.create(dto);
        if (!result.success) {
            writeError(res, 400, result.error);
            return;
        }

        res.statusCode = cast(int) HTTPStatus.created;
        auto body = Json.emptyObject;
        body["id"] = Json(result.id);
        writeJsonBody(res, body);
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        FreightOrderDTO dto;
        dto.id = extractIdFromPath(req.requestPath.to!string);
        dto.orderNumber = jsonStr(j, "orderNumber");
        dto.shipperId = jsonStr(j, "shipperId");
        dto.carrierId = jsonStr(j, "carrierId");
        dto.transportMode = jsonStr(j, "transportMode");
        dto.status = jsonStr(j, "status");
        dto.originLocation = jsonStr(j, "originLocation");
        dto.destinationLocation = jsonStr(j, "destinationLocation");
        dto.plannedPickup = jsonStr(j, "plannedPickup");
        dto.plannedDelivery = jsonStr(j, "plannedDelivery");
        dto.modifiedBy = jsonStr(j, "modifiedBy");
        dto.modifiedAt = jsonStr(j, "modifiedAt");

        auto result = useCase.update(dto);
        if (!result.success) {
            writeError(res, 404, result.error);
            return;
        }

        auto body = Json.emptyObject;
        body["id"] = Json(result.id);
        writeJsonBody(res, body);
    }

    private void handleDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto result = useCase.remove(id);
        if (!result.success) {
            writeError(res, 404, result.error);
            return;
        }
        res.statusCode = cast(int) HTTPStatus.noContent;
        res.writeBody("");
    }
}
