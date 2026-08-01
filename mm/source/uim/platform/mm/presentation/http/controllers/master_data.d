module uim.platform.mm.presentation.http.controllers.master_data;

import std.conv : to;
import uim.platform.mm;

@safe:

class MasterDataController : SAPController {
    private ManageMaterialsUseCase materials;
    private ManagePlantsUseCase plants;
    private ManageStorageLocationsUseCase storageLocations;
    private ManageVendorsUseCase vendors;
    private ManagePurchasingInfoRecordsUseCase infoRecords;

    this(
        ManageMaterialsUseCase materials,
        ManagePlantsUseCase plants,
        ManageStorageLocationsUseCase storageLocations,
        ManageVendorsUseCase vendors,
        ManagePurchasingInfoRecordsUseCase infoRecords
    ) {
        this.materials = materials;
        this.plants = plants;
        this.storageLocations = storageLocations;
        this.vendors = vendors;
        this.infoRecords = infoRecords;
    }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);

        router.get("/api/v1/mm/materials", &handleListMaterials);
        router.get("/api/v1/mm/materials/*", &handleGetMaterial);
        router.post("/api/v1/mm/materials", &handleCreateMaterial);
        router.put("/api/v1/mm/materials/*", &handleUpdateMaterial);
        router.delete_("/api/v1/mm/materials/*", &handleDeleteMaterial);

        router.get("/api/v1/mm/plants", &handleListPlants);
        router.get("/api/v1/mm/plants/*", &handleGetPlant);
        router.post("/api/v1/mm/plants", &handleCreatePlant);
        router.put("/api/v1/mm/plants/*", &handleUpdatePlant);
        router.delete_("/api/v1/mm/plants/*", &handleDeletePlant);

        router.get("/api/v1/mm/storage-locations", &handleListStorageLocations);
        router.get("/api/v1/mm/storage-locations/*", &handleGetStorageLocation);
        router.post("/api/v1/mm/storage-locations", &handleCreateStorageLocation);
        router.put("/api/v1/mm/storage-locations/*", &handleUpdateStorageLocation);
        router.delete_("/api/v1/mm/storage-locations/*", &handleDeleteStorageLocation);

        router.get("/api/v1/mm/vendors", &handleListVendors);
        router.get("/api/v1/mm/vendors/*", &handleGetVendor);
        router.post("/api/v1/mm/vendors", &handleCreateVendor);
        router.put("/api/v1/mm/vendors/*", &handleUpdateVendor);
        router.delete_("/api/v1/mm/vendors/*", &handleDeleteVendor);

        router.get("/api/v1/mm/purchasing-info-records", &handleListInfoRecords);
        router.get("/api/v1/mm/purchasing-info-records/*", &handleGetInfoRecord);
        router.post("/api/v1/mm/purchasing-info-records", &handleCreateInfoRecord);
        router.put("/api/v1/mm/purchasing-info-records/*", &handleUpdateInfoRecord);
        router.delete_("/api/v1/mm/purchasing-info-records/*", &handleDeleteInfoRecord);
    }

    private void handleListMaterials(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        writeListResponse!Material(res, materials.list(), &materialToJson);
    }

    private void handleGetMaterial(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto item = materials.get_(extractIdFromPath(req.requestURI.to!string));
        if (item is null) { writeError(res, 404, "Material not found"); return; }
        res.writeJsonBody(materialToJson(*item), 200);
    }

    private void handleCreateMaterial(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        MaterialDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = tenantIdOf(req);
        dto.materialNumber = jsonStr(j, "materialNumber");
        dto.description = jsonStr(j, "description");
        dto.baseUnit = jsonStr(j, "baseUnit");
        dto.materialType = jsonStr(j, "materialType");
        dto.materialGroup = jsonStr(j, "materialGroup");
        dto.valuationClass = jsonStr(j, "valuationClass");
        dto.status = jsonStr(j, "status");
        dto.createdBy = jsonStr(j, "createdBy");
        dto.createdAt = jsonStr(j, "createdAt");
        writeCommandResult(res, materials.create(dto), 201, "Material created", 400);
    }

    private void handleUpdateMaterial(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        MaterialDTO dto;
        dto.id = extractIdFromPath(req.requestURI.to!string);
        dto.materialNumber = jsonStr(j, "materialNumber");
        dto.description = jsonStr(j, "description");
        dto.baseUnit = jsonStr(j, "baseUnit");
        dto.materialType = jsonStr(j, "materialType");
        dto.materialGroup = jsonStr(j, "materialGroup");
        dto.valuationClass = jsonStr(j, "valuationClass");
        dto.status = jsonStr(j, "status");
        dto.modifiedBy = jsonStr(j, "modifiedBy");
        dto.modifiedAt = jsonStr(j, "modifiedAt");
        writeCommandResult(res, materials.update(dto), 200, "Material updated", 404);
    }

    private void handleDeleteMaterial(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        writeDeleteResult(res, materials.remove(extractIdFromPath(req.requestURI.to!string)), "Material deleted");
    }

    private void handleListPlants(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        writeListResponse!Plant(res, plants.list(), &plantToJson);
    }

    private void handleGetPlant(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto item = plants.get_(extractIdFromPath(req.requestURI.to!string));
        if (item is null) { writeError(res, 404, "Plant not found"); return; }
        res.writeJsonBody(plantToJson(*item), 200);
    }

    private void handleCreatePlant(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        PlantDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = tenantIdOf(req);
        dto.plantCode = jsonStr(j, "plantCode");
        dto.name = jsonStr(j, "name");
        dto.companyCode = jsonStr(j, "companyCode");
        dto.country = jsonStr(j, "country");
        dto.purchasingOrg = jsonStr(j, "purchasingOrg");
        dto.createdBy = jsonStr(j, "createdBy");
        dto.createdAt = jsonStr(j, "createdAt");
        writeCommandResult(res, plants.create(dto), 201, "Plant created", 400);
    }

    private void handleUpdatePlant(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        PlantDTO dto;
        dto.id = extractIdFromPath(req.requestURI.to!string);
        dto.plantCode = jsonStr(j, "plantCode");
        dto.name = jsonStr(j, "name");
        dto.companyCode = jsonStr(j, "companyCode");
        dto.country = jsonStr(j, "country");
        dto.purchasingOrg = jsonStr(j, "purchasingOrg");
        dto.modifiedBy = jsonStr(j, "modifiedBy");
        dto.modifiedAt = jsonStr(j, "modifiedAt");
        writeCommandResult(res, plants.update(dto), 200, "Plant updated", 404);
    }

    private void handleDeletePlant(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        writeDeleteResult(res, plants.remove(extractIdFromPath(req.requestURI.to!string)), "Plant deleted");
    }

    private void handleListStorageLocations(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        writeListResponse!StorageLocation(res, storageLocations.list(), &storageLocationToJson);
    }

    private void handleGetStorageLocation(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto item = storageLocations.get_(extractIdFromPath(req.requestURI.to!string));
        if (item is null) { writeError(res, 404, "Storage location not found"); return; }
        res.writeJsonBody(storageLocationToJson(*item), 200);
    }

    private void handleCreateStorageLocation(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        StorageLocationDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = tenantIdOf(req);
        dto.plantId = jsonStr(j, "plantId");
        dto.storageLocationCode = jsonStr(j, "storageLocationCode");
        dto.name = jsonStr(j, "name");
        dto.description = jsonStr(j, "description");
        dto.createdBy = jsonStr(j, "createdBy");
        dto.createdAt = jsonStr(j, "createdAt");
        writeCommandResult(res, storageLocations.create(dto), 201, "Storage location created", 400);
    }

    private void handleUpdateStorageLocation(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        StorageLocationDTO dto;
        dto.id = extractIdFromPath(req.requestURI.to!string);
        dto.plantId = jsonStr(j, "plantId");
        dto.storageLocationCode = jsonStr(j, "storageLocationCode");
        dto.name = jsonStr(j, "name");
        dto.description = jsonStr(j, "description");
        dto.modifiedBy = jsonStr(j, "modifiedBy");
        dto.modifiedAt = jsonStr(j, "modifiedAt");
        writeCommandResult(res, storageLocations.update(dto), 200, "Storage location updated", 404);
    }

    private void handleDeleteStorageLocation(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        writeDeleteResult(
            res,
            storageLocations.remove(extractIdFromPath(req.requestURI.to!string)),
            "Storage location deleted"
        );
    }

    private void handleListVendors(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        writeListResponse!SupplierVendor(res, vendors.list(), &vendorToJson);
    }

    private void handleGetVendor(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto item = vendors.get_(extractIdFromPath(req.requestURI.to!string));
        if (item is null) { writeError(res, 404, "Vendor not found"); return; }
        res.writeJsonBody(vendorToJson(*item), 200);
    }

    private void handleCreateVendor(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        VendorDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = tenantIdOf(req);
        dto.vendorNumber = jsonStr(j, "vendorNumber");
        dto.name = jsonStr(j, "name");
        dto.purchasingOrg = jsonStr(j, "purchasingOrg");
        dto.currency = jsonStr(j, "currency");
        dto.paymentTerms = jsonStr(j, "paymentTerms");
        dto.incoterms = jsonStr(j, "incoterms");
        dto.createdBy = jsonStr(j, "createdBy");
        dto.createdAt = jsonStr(j, "createdAt");
        writeCommandResult(res, vendors.create(dto), 201, "Vendor created", 400);
    }

    private void handleUpdateVendor(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        VendorDTO dto;
        dto.id = extractIdFromPath(req.requestURI.to!string);
        dto.vendorNumber = jsonStr(j, "vendorNumber");
        dto.name = jsonStr(j, "name");
        dto.purchasingOrg = jsonStr(j, "purchasingOrg");
        dto.currency = jsonStr(j, "currency");
        dto.paymentTerms = jsonStr(j, "paymentTerms");
        dto.incoterms = jsonStr(j, "incoterms");
        dto.modifiedBy = jsonStr(j, "modifiedBy");
        dto.modifiedAt = jsonStr(j, "modifiedAt");
        writeCommandResult(res, vendors.update(dto), 200, "Vendor updated", 404);
    }

    private void handleDeleteVendor(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        writeDeleteResult(res, vendors.remove(extractIdFromPath(req.requestURI.to!string)), "Vendor deleted");
    }

    private void handleListInfoRecords(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        writeListResponse!PurchasingInfoRecord(res, infoRecords.list(), &purchasingInfoRecordToJson);
    }

    private void handleGetInfoRecord(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto item = infoRecords.get_(extractIdFromPath(req.requestURI.to!string));
        if (item is null) { writeError(res, 404, "Purchasing info record not found"); return; }
        res.writeJsonBody(purchasingInfoRecordToJson(*item), 200);
    }

    private void handleCreateInfoRecord(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        PurchasingInfoRecordDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = tenantIdOf(req);
        dto.materialId = jsonStr(j, "materialId");
        dto.vendorId = jsonStr(j, "vendorId");
        dto.plantId = jsonStr(j, "plantId");
        dto.purchasingOrg = jsonStr(j, "purchasingOrg");
        dto.orderUnit = jsonStr(j, "orderUnit");
        dto.netPrice = jsonStr(j, "netPrice");
        dto.currency = jsonStr(j, "currency");
        dto.leadTimeDays = jsonStr(j, "leadTimeDays");
        dto.minimumOrderQuantity = jsonStr(j, "minimumOrderQuantity");
        dto.sourceListNote = jsonStr(j, "sourceListNote");
        dto.createdBy = jsonStr(j, "createdBy");
        dto.createdAt = jsonStr(j, "createdAt");
        writeCommandResult(res, infoRecords.create(dto), 201, "Purchasing info record created", 400);
    }

    private void handleUpdateInfoRecord(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        PurchasingInfoRecordDTO dto;
        dto.id = extractIdFromPath(req.requestURI.to!string);
        dto.materialId = jsonStr(j, "materialId");
        dto.vendorId = jsonStr(j, "vendorId");
        dto.plantId = jsonStr(j, "plantId");
        dto.purchasingOrg = jsonStr(j, "purchasingOrg");
        dto.orderUnit = jsonStr(j, "orderUnit");
        dto.netPrice = jsonStr(j, "netPrice");
        dto.currency = jsonStr(j, "currency");
        dto.leadTimeDays = jsonStr(j, "leadTimeDays");
        dto.minimumOrderQuantity = jsonStr(j, "minimumOrderQuantity");
        dto.sourceListNote = jsonStr(j, "sourceListNote");
        dto.modifiedBy = jsonStr(j, "modifiedBy");
        dto.modifiedAt = jsonStr(j, "modifiedAt");
        writeCommandResult(res, infoRecords.update(dto), 200, "Purchasing info record updated", 404);
    }

    private void handleDeleteInfoRecord(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        writeDeleteResult(
            res,
            infoRecords.remove(extractIdFromPath(req.requestURI.to!string)),
            "Purchasing info record deleted"
        );
    }

    private string tenantIdOf(scope HTTPServerRequest req) {
        return req.headers.get("X-Tenant-Id", "");
    }

    private void writeCommandResult(
        scope HTTPServerResponse res,
        CommandResult result,
        int successStatus,
        string successMessage,
        int failureStatus
    ) {
        if (result.success) {
            res.writeJsonBody(successPayload(result.id, successMessage), successStatus);
        } else {
            writeError(res, failureStatus, result.error);
        }
    }

    private void writeDeleteResult(scope HTTPServerResponse res, CommandResult result, string message) {
        if (result.success) {
            res.writeJsonBody(successPayload(result.id, message), 200);
        } else {
            writeError(res, 404, result.error);
        }
    }

    private void writeListResponse(T)(scope HTTPServerResponse res, T[] items, Json function(T) @safe mapper) {
        auto resources = Json.emptyArray;
        foreach (item; items) resources ~= mapper(item);
        auto payload = Json.emptyObject;
        payload["count"] = Json(cast(long) items.length);
        payload["resources"] = resources;
        res.writeJsonBody(payload, 200);
    }
}