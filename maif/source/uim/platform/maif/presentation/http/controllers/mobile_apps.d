module uim.platform.maif.presentation.http.controllers.mobile_apps;

import std.conv : to;
import uim.platform.maif;

@safe:

class MobileAppController : SAPController {
    private ManageMobileAppsUseCase useCase;

    this(ManageMobileAppsUseCase useCase) {
        this.useCase = useCase;
    }

    override void registerRoutes(URLRouter router) {
        router.get("/api/v1/maif/mobile-apps", &handleList);
        router.get("/api/v1/maif/mobile-apps/*", &handleGet);
        router.post("/api/v1/maif/mobile-apps", &handleCreate);
        router.put("/api/v1/maif/mobile-apps/*", &handleUpdate);
        router.delete_("/api/v1/maif/mobile-apps/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto items = useCase.list();
        auto arr = Json.emptyArray;
        foreach (item; items) {
            arr ~= mobileAppToJson(item);
        }

        auto payload = Json.emptyObject;
        payload["count"] = Json(cast(long) items.length);
        payload["resources"] = arr;
        res.writeJsonBody(payload, 200);
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto item = useCase.get_(id);
        if (item is null) {
            writeError(res, 404, "Mobile app not found");
            return;
        }
        res.writeJsonBody(mobileAppToJson(*item), 200);
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;

        MobileAppDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = req.headers.get("X-Tenant-Id", "");
        dto.name = jsonStr(j, "name");
        dto.description = jsonStr(j, "description");
        dto.platform = jsonStr(j, "platform");
        dto.versionTag = jsonStr(j, "versionTag");
        dto.status = jsonStr(j, "status");
        dto.owner = jsonStr(j, "owner");
        dto.backendSystem = jsonStr(j, "backendSystem");
        dto.authProfile = jsonStr(j, "authProfile");
        dto.createdBy = jsonStr(j, "createdBy");

        auto result = useCase.create(dto);
        if (!result.success) {
            writeError(res, 400, result.error);
            return;
        }

        auto payload = Json.emptyObject;
        payload["id"] = Json(result.id);
        res.writeJsonBody(payload, 201);
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;

        MobileAppDTO dto;
        dto.id = extractIdFromPath(req.requestPath.to!string);
        dto.name = jsonStr(j, "name");
        dto.description = jsonStr(j, "description");
        dto.platform = jsonStr(j, "platform");
        dto.versionTag = jsonStr(j, "versionTag");
        dto.status = jsonStr(j, "status");
        dto.owner = jsonStr(j, "owner");
        dto.backendSystem = jsonStr(j, "backendSystem");
        dto.authProfile = jsonStr(j, "authProfile");
        dto.modifiedBy = jsonStr(j, "modifiedBy");

        auto result = useCase.update(dto);
        if (!result.success) {
            writeError(res, 404, result.error);
            return;
        }

        auto payload = Json.emptyObject;
        payload["id"] = Json(result.id);
        res.writeJsonBody(payload, 200);
    }

    private void handleDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto result = useCase.remove(id);
        if (!result.success) {
            writeError(res, 404, result.error);
            return;
        }

        auto payload = Json.emptyObject;
        payload["id"] = Json(result.id);
        payload["message"] = Json("Mobile app deleted");
        res.writeJsonBody(payload, 200);
    }
}
