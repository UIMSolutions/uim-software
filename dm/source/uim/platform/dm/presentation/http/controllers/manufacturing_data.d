module uim.platform.dm.presentation.http.controllers.manufacturing_data;

import std.conv : to;

import uim.platform.dm;

@safe:

private Json listResponse(T)(T[] values, Json function(ref T) @safe serializer) {
    auto resources = Json.emptyArray;
    foreach (ref value; values)
        resources ~= serializer(value);

    auto body = Json.emptyObject;
    body["count"] = Json(cast(long) values.length);
    body["resources"] = resources;
    return body;
}

class ProductionOrderController : SAPController {
    private ManageProductionOrdersUseCase uc;

    this(ManageProductionOrdersUseCase uc) { this.uc = uc; }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/api/v1/dm/production-orders", &handleList);
        router.get("/api/v1/dm/production-orders/*", &handleGet);
        router.post("/api/v1/dm/production-orders", &handleCreate);
        router.put("/api/v1/dm/production-orders/*", &handleUpdate);
        router.delete_("/api/v1/dm/production-orders/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try res.writeJsonBody(listResponse(uc.list(), &productionOrderToJson), 200);
        catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto value = uc.get_(extractIdFromPath(req.requestURI.to!string));
            if (value is null) { writeError(res, 404, "Production order not found"); return; }
            res.writeJsonBody(productionOrderToJson(*value), 200);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            ProductionOrderDTO dto;
            dto.id = jsonStr(j, "id");
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.orderNumber = jsonStr(j, "orderNumber");
            dto.materialId = jsonStr(j, "materialId");
            dto.plant = jsonStr(j, "plant");
            dto.quantity = jsonStr(j, "quantity");
            dto.unit = jsonStr(j, "unit");
            dto.scheduledStart = jsonStr(j, "scheduledStart");
            dto.scheduledEnd = jsonStr(j, "scheduledEnd");
            dto.status = jsonStr(j, "status");
            dto.createdBy = jsonStr(j, "createdBy");

            auto result = uc.create(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Production order created");
                res.writeJsonBody(body, 201);
            } else writeError(res, 400, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            ProductionOrderDTO dto;
            dto.id = extractIdFromPath(req.requestURI.to!string);
            dto.plant = jsonStr(j, "plant");
            dto.quantity = jsonStr(j, "quantity");
            dto.unit = jsonStr(j, "unit");
            dto.scheduledStart = jsonStr(j, "scheduledStart");
            dto.scheduledEnd = jsonStr(j, "scheduledEnd");
            dto.status = jsonStr(j, "status");
            dto.modifiedBy = jsonStr(j, "modifiedBy");

            auto result = uc.update(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Production order updated");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto result = uc.remove(extractIdFromPath(req.requestURI.to!string));
            if (result.success) {
                auto body = Json.emptyObject;
                body["message"] = Json("Production order deleted");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }
}

class OperationActivityController : SAPController {
    private ManageOperationActivitiesUseCase uc;

    this(ManageOperationActivitiesUseCase uc) { this.uc = uc; }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/api/v1/dm/operation-activities", &handleList);
        router.get("/api/v1/dm/operation-activities/*", &handleGet);
        router.post("/api/v1/dm/operation-activities", &handleCreate);
        router.put("/api/v1/dm/operation-activities/*", &handleUpdate);
        router.delete_("/api/v1/dm/operation-activities/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try res.writeJsonBody(listResponse(uc.list(), &operationActivityToJson), 200);
        catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto value = uc.get_(extractIdFromPath(req.requestURI.to!string));
            if (value is null) { writeError(res, 404, "Operation activity not found"); return; }
            res.writeJsonBody(operationActivityToJson(*value), 200);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            OperationActivityDTO dto;
            dto.id = jsonStr(j, "id");
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.productionOrderId = jsonStr(j, "productionOrderId");
            dto.operationCode = jsonStr(j, "operationCode");
            dto.workCenterId = jsonStr(j, "workCenterId");
            dto.sequence = jsonStr(j, "sequence");
            dto.plannedDuration = jsonStr(j, "plannedDuration");
            dto.status = jsonStr(j, "status");
            dto.createdBy = jsonStr(j, "createdBy");

            auto result = uc.create(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Operation activity created");
                res.writeJsonBody(body, 201);
            } else writeError(res, 400, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            OperationActivityDTO dto;
            dto.id = extractIdFromPath(req.requestURI.to!string);
            dto.workCenterId = jsonStr(j, "workCenterId");
            dto.sequence = jsonStr(j, "sequence");
            dto.plannedDuration = jsonStr(j, "plannedDuration");
            dto.status = jsonStr(j, "status");
            dto.modifiedBy = jsonStr(j, "modifiedBy");

            auto result = uc.update(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Operation activity updated");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto result = uc.remove(extractIdFromPath(req.requestURI.to!string));
            if (result.success) {
                auto body = Json.emptyObject;
                body["message"] = Json("Operation activity deleted");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }
}

class DMWorkCenterController : SAPController {
    private ManageWorkCentersUseCase uc;

    this(ManageWorkCentersUseCase uc) { this.uc = uc; }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/api/v1/dm/work-centers", &handleList);
        router.get("/api/v1/dm/work-centers/*", &handleGet);
        router.post("/api/v1/dm/work-centers", &handleCreate);
        router.put("/api/v1/dm/work-centers/*", &handleUpdate);
        router.delete_("/api/v1/dm/work-centers/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try res.writeJsonBody(listResponse(uc.list(), &workCenterToJson), 200);
        catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto value = uc.get_(extractIdFromPath(req.requestURI.to!string));
            if (value is null) { writeError(res, 404, "Work center not found"); return; }
            res.writeJsonBody(workCenterToJson(*value), 200);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            WorkCenterDTO dto;
            dto.id = jsonStr(j, "id");
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.centerCode = jsonStr(j, "centerCode");
            dto.description = jsonStr(j, "description");
            dto.plant = jsonStr(j, "plant");
            dto.capacity = jsonStr(j, "capacity");
            dto.capacityUnit = jsonStr(j, "capacityUnit");
            dto.createdBy = jsonStr(j, "createdBy");

            auto result = uc.create(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Work center created");
                res.writeJsonBody(body, 201);
            } else writeError(res, 400, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            WorkCenterDTO dto;
            dto.id = extractIdFromPath(req.requestURI.to!string);
            dto.description = jsonStr(j, "description");
            dto.plant = jsonStr(j, "plant");
            dto.capacity = jsonStr(j, "capacity");
            dto.capacityUnit = jsonStr(j, "capacityUnit");
            dto.modifiedBy = jsonStr(j, "modifiedBy");

            auto result = uc.update(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Work center updated");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto result = uc.remove(extractIdFromPath(req.requestURI.to!string));
            if (result.success) {
                auto body = Json.emptyObject;
                body["message"] = Json("Work center deleted");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }
}

class DMResourceController : SAPController {
    private ManageResourcesUseCase uc;

    this(ManageResourcesUseCase uc) { this.uc = uc; }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/api/v1/dm/resources", &handleList);
        router.get("/api/v1/dm/resources/*", &handleGet);
        router.post("/api/v1/dm/resources", &handleCreate);
        router.put("/api/v1/dm/resources/*", &handleUpdate);
        router.delete_("/api/v1/dm/resources/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try res.writeJsonBody(listResponse(uc.list(), &resourceToJson), 200);
        catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto value = uc.get_(extractIdFromPath(req.requestURI.to!string));
            if (value is null) { writeError(res, 404, "Resource not found"); return; }
            res.writeJsonBody(resourceToJson(*value), 200);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            ResourceDTO dto;
            dto.id = jsonStr(j, "id");
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.resourceCode = jsonStr(j, "resourceCode");
            dto.workCenterId = jsonStr(j, "workCenterId");
            dto.resourceType = jsonStr(j, "resourceType");
            dto.availability = jsonStr(j, "availability");
            dto.createdBy = jsonStr(j, "createdBy");

            auto result = uc.create(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Resource created");
                res.writeJsonBody(body, 201);
            } else writeError(res, 400, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            ResourceDTO dto;
            dto.id = extractIdFromPath(req.requestURI.to!string);
            dto.workCenterId = jsonStr(j, "workCenterId");
            dto.resourceType = jsonStr(j, "resourceType");
            dto.availability = jsonStr(j, "availability");
            dto.modifiedBy = jsonStr(j, "modifiedBy");

            auto result = uc.update(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Resource updated");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto result = uc.remove(extractIdFromPath(req.requestURI.to!string));
            if (result.success) {
                auto body = Json.emptyObject;
                body["message"] = Json("Resource deleted");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }
}

class DMMaterialController : SAPController {
    private ManageMaterialsUseCase uc;

    this(ManageMaterialsUseCase uc) { this.uc = uc; }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/api/v1/dm/materials", &handleList);
        router.get("/api/v1/dm/materials/*", &handleGet);
        router.post("/api/v1/dm/materials", &handleCreate);
        router.put("/api/v1/dm/materials/*", &handleUpdate);
        router.delete_("/api/v1/dm/materials/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try res.writeJsonBody(listResponse(uc.list(), &materialToJson), 200);
        catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto value = uc.get_(extractIdFromPath(req.requestURI.to!string));
            if (value is null) { writeError(res, 404, "Material not found"); return; }
            res.writeJsonBody(materialToJson(*value), 200);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            MaterialDTO dto;
            dto.id = jsonStr(j, "id");
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.materialNumber = jsonStr(j, "materialNumber");
            dto.description = jsonStr(j, "description");
            dto.baseUnit = jsonStr(j, "baseUnit");
            dto.revision = jsonStr(j, "revision");
            dto.createdBy = jsonStr(j, "createdBy");

            auto result = uc.create(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Material created");
                res.writeJsonBody(body, 201);
            } else writeError(res, 400, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            MaterialDTO dto;
            dto.id = extractIdFromPath(req.requestURI.to!string);
            dto.description = jsonStr(j, "description");
            dto.baseUnit = jsonStr(j, "baseUnit");
            dto.revision = jsonStr(j, "revision");
            dto.modifiedBy = jsonStr(j, "modifiedBy");

            auto result = uc.update(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Material updated");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto result = uc.remove(extractIdFromPath(req.requestURI.to!string));
            if (result.success) {
                auto body = Json.emptyObject;
                body["message"] = Json("Material deleted");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }
}

class ShopFloorControlController : SAPController {
    private ManageShopFloorControlsUseCase uc;

    this(ManageShopFloorControlsUseCase uc) { this.uc = uc; }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/api/v1/dm/shop-floor-controls", &handleList);
        router.get("/api/v1/dm/shop-floor-controls/*", &handleGet);
        router.post("/api/v1/dm/shop-floor-controls", &handleCreate);
        router.put("/api/v1/dm/shop-floor-controls/*", &handleUpdate);
        router.delete_("/api/v1/dm/shop-floor-controls/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try res.writeJsonBody(listResponse(uc.list(), &shopFloorControlToJson), 200);
        catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto value = uc.get_(extractIdFromPath(req.requestURI.to!string));
            if (value is null) { writeError(res, 404, "Shop floor control not found"); return; }
            res.writeJsonBody(shopFloorControlToJson(*value), 200);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            ShopFloorControlDTO dto;
            dto.id = jsonStr(j, "id");
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.productionOrderId = jsonStr(j, "productionOrderId");
            dto.dispatchRule = jsonStr(j, "dispatchRule");
            dto.priority = jsonStr(j, "priority");
            dto.mode = jsonStr(j, "mode");
            dto.releaseStrategy = jsonStr(j, "releaseStrategy");
            dto.createdBy = jsonStr(j, "createdBy");

            auto result = uc.create(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Shop floor control created");
                res.writeJsonBody(body, 201);
            } else writeError(res, 400, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            ShopFloorControlDTO dto;
            dto.id = extractIdFromPath(req.requestURI.to!string);
            dto.dispatchRule = jsonStr(j, "dispatchRule");
            dto.priority = jsonStr(j, "priority");
            dto.mode = jsonStr(j, "mode");
            dto.releaseStrategy = jsonStr(j, "releaseStrategy");
            dto.modifiedBy = jsonStr(j, "modifiedBy");

            auto result = uc.update(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Shop floor control updated");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto result = uc.remove(extractIdFromPath(req.requestURI.to!string));
            if (result.success) {
                auto body = Json.emptyObject;
                body["message"] = Json("Shop floor control deleted");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }
}

class WorkInstructionController : SAPController {
    private ManageWorkInstructionsUseCase uc;

    this(ManageWorkInstructionsUseCase uc) { this.uc = uc; }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/api/v1/dm/work-instructions", &handleList);
        router.get("/api/v1/dm/work-instructions/*", &handleGet);
        router.post("/api/v1/dm/work-instructions", &handleCreate);
        router.put("/api/v1/dm/work-instructions/*", &handleUpdate);
        router.delete_("/api/v1/dm/work-instructions/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try res.writeJsonBody(listResponse(uc.list(), &workInstructionToJson), 200);
        catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto value = uc.get_(extractIdFromPath(req.requestURI.to!string));
            if (value is null) { writeError(res, 404, "Work instruction not found"); return; }
            res.writeJsonBody(workInstructionToJson(*value), 200);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            WorkInstructionDTO dto;
            dto.id = jsonStr(j, "id");
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.operationActivityId = jsonStr(j, "operationActivityId");
            dto.title = jsonStr(j, "title");
            dto.documentRef = jsonStr(j, "documentRef");
            dto.instructionVersion = jsonStr(j, "version");
            dto.language = jsonStr(j, "language");
            dto.createdBy = jsonStr(j, "createdBy");

            auto result = uc.create(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Work instruction created");
                res.writeJsonBody(body, 201);
            } else writeError(res, 400, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            WorkInstructionDTO dto;
            dto.id = extractIdFromPath(req.requestURI.to!string);
            dto.title = jsonStr(j, "title");
            dto.documentRef = jsonStr(j, "documentRef");
            dto.instructionVersion = jsonStr(j, "version");
            dto.language = jsonStr(j, "language");
            dto.modifiedBy = jsonStr(j, "modifiedBy");

            auto result = uc.update(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Work instruction updated");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto result = uc.remove(extractIdFromPath(req.requestURI.to!string));
            if (result.success) {
                auto body = Json.emptyObject;
                body["message"] = Json("Work instruction deleted");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }
}

class QualityInspectionController : SAPController {
    private ManageQualityInspectionsUseCase uc;

    this(ManageQualityInspectionsUseCase uc) { this.uc = uc; }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/api/v1/dm/quality-inspections", &handleList);
        router.get("/api/v1/dm/quality-inspections/*", &handleGet);
        router.post("/api/v1/dm/quality-inspections", &handleCreate);
        router.put("/api/v1/dm/quality-inspections/*", &handleUpdate);
        router.delete_("/api/v1/dm/quality-inspections/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try res.writeJsonBody(listResponse(uc.list(), &qualityInspectionToJson), 200);
        catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto value = uc.get_(extractIdFromPath(req.requestURI.to!string));
            if (value is null) { writeError(res, 404, "Quality inspection not found"); return; }
            res.writeJsonBody(qualityInspectionToJson(*value), 200);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            QualityInspectionDTO dto;
            dto.id = jsonStr(j, "id");
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.productionOrderId = jsonStr(j, "productionOrderId");
            dto.characteristic = jsonStr(j, "characteristic");
            dto.sampleSize = jsonStr(j, "sampleSize");
            dto.resultValue = jsonStr(j, "resultValue");
            dto.status = jsonStr(j, "status");
            dto.inspector = jsonStr(j, "inspector");
            dto.createdBy = jsonStr(j, "createdBy");

            auto result = uc.create(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Quality inspection created");
                res.writeJsonBody(body, 201);
            } else writeError(res, 400, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            QualityInspectionDTO dto;
            dto.id = extractIdFromPath(req.requestURI.to!string);
            dto.sampleSize = jsonStr(j, "sampleSize");
            dto.resultValue = jsonStr(j, "resultValue");
            dto.status = jsonStr(j, "status");
            dto.inspector = jsonStr(j, "inspector");
            dto.modifiedBy = jsonStr(j, "modifiedBy");

            auto result = uc.update(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Quality inspection updated");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto result = uc.remove(extractIdFromPath(req.requestURI.to!string));
            if (result.success) {
                auto body = Json.emptyObject;
                body["message"] = Json("Quality inspection deleted");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }
}

class NonconformanceController : SAPController {
    private ManageNonconformancesUseCase uc;

    this(ManageNonconformancesUseCase uc) { this.uc = uc; }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/api/v1/dm/nonconformances", &handleList);
        router.get("/api/v1/dm/nonconformances/*", &handleGet);
        router.post("/api/v1/dm/nonconformances", &handleCreate);
        router.put("/api/v1/dm/nonconformances/*", &handleUpdate);
        router.delete_("/api/v1/dm/nonconformances/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try res.writeJsonBody(listResponse(uc.list(), &nonconformanceToJson), 200);
        catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto value = uc.get_(extractIdFromPath(req.requestURI.to!string));
            if (value is null) { writeError(res, 404, "Nonconformance not found"); return; }
            res.writeJsonBody(nonconformanceToJson(*value), 200);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            NonconformanceDTO dto;
            dto.id = jsonStr(j, "id");
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.productionOrderId = jsonStr(j, "productionOrderId");
            dto.defectCode = jsonStr(j, "defectCode");
            dto.defectText = jsonStr(j, "defectText");
            dto.severity = jsonStr(j, "severity");
            dto.disposition = jsonStr(j, "disposition");
            dto.createdBy = jsonStr(j, "createdBy");

            auto result = uc.create(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Nonconformance created");
                res.writeJsonBody(body, 201);
            } else writeError(res, 400, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            NonconformanceDTO dto;
            dto.id = extractIdFromPath(req.requestURI.to!string);
            dto.defectText = jsonStr(j, "defectText");
            dto.severity = jsonStr(j, "severity");
            dto.disposition = jsonStr(j, "disposition");
            dto.modifiedBy = jsonStr(j, "modifiedBy");

            auto result = uc.update(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Nonconformance updated");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto result = uc.remove(extractIdFromPath(req.requestURI.to!string));
            if (result.success) {
                auto body = Json.emptyObject;
                body["message"] = Json("Nonconformance deleted");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }
}

class GenealogyRecordController : SAPController {
    private ManageGenealogyRecordsUseCase uc;

    this(ManageGenealogyRecordsUseCase uc) { this.uc = uc; }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/api/v1/dm/genealogy-records", &handleList);
        router.get("/api/v1/dm/genealogy-records/*", &handleGet);
        router.post("/api/v1/dm/genealogy-records", &handleCreate);
        router.put("/api/v1/dm/genealogy-records/*", &handleUpdate);
        router.delete_("/api/v1/dm/genealogy-records/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try res.writeJsonBody(listResponse(uc.list(), &genealogyRecordToJson), 200);
        catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto value = uc.get_(extractIdFromPath(req.requestURI.to!string));
            if (value is null) { writeError(res, 404, "Genealogy record not found"); return; }
            res.writeJsonBody(genealogyRecordToJson(*value), 200);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            GenealogyRecordDTO dto;
            dto.id = jsonStr(j, "id");
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.productionOrderId = jsonStr(j, "productionOrderId");
            dto.parentSerial = jsonStr(j, "parentSerial");
            dto.childSerial = jsonStr(j, "childSerial");
            dto.componentMaterialId = jsonStr(j, "componentMaterialId");
            dto.assembledAt = jsonStr(j, "assembledAt");
            dto.createdBy = jsonStr(j, "createdBy");

            auto result = uc.create(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Genealogy record created");
                res.writeJsonBody(body, 201);
            } else writeError(res, 400, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            GenealogyRecordDTO dto;
            dto.id = extractIdFromPath(req.requestURI.to!string);
            dto.parentSerial = jsonStr(j, "parentSerial");
            dto.childSerial = jsonStr(j, "childSerial");
            dto.componentMaterialId = jsonStr(j, "componentMaterialId");
            dto.assembledAt = jsonStr(j, "assembledAt");
            dto.modifiedBy = jsonStr(j, "modifiedBy");

            auto result = uc.update(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Genealogy record updated");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto result = uc.remove(extractIdFromPath(req.requestURI.to!string));
            if (result.success) {
                auto body = Json.emptyObject;
                body["message"] = Json("Genealogy record deleted");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }
}
