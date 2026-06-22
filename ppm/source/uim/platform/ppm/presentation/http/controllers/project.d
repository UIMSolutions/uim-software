module uim.platform.ppm.presentation.http.controllers.project;

import std.conv : to;
import uim.platform.ppm;

@safe:

class ProjectController : SAPController {
    private ManageProjectsUseCase useCase;

    this(ManageProjectsUseCase useCase) { this.useCase = useCase; }

    override void registerRoutes(URLRouter router) {
        router.get("/api/v1/ppm/projects", &handleList);
        router.get("/api/v1/ppm/projects/*", &handleGet);
        router.post("/api/v1/ppm/projects", &handleCreate);
        router.put("/api/v1/ppm/projects/*", &handleUpdate);
        router.delete_("/api/v1/ppm/projects/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto items = useCase.list();
        auto arr = Json.emptyArray;
        foreach (item; items) arr ~= projectToJson(item);
        writeJsonBody(res, Json(["count": Json(cast(long) items.length), "resources": arr]));
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto item = useCase.get_(id);
        if (item is null) { writeError(res, 404, "Project not found"); return; }
        writeJsonBody(res, projectToJson(*item));
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        ProjectDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = req.headers.get("X-Tenant-Id", "");
        dto.programId = jsonStr(j, "programId");
        dto.name = jsonStr(j, "name");
        dto.description = jsonStr(j, "description");
        dto.projectType = jsonStr(j, "projectType");
        dto.status = jsonStr(j, "status");
        dto.startDate = jsonStr(j, "startDate");
        dto.endDate = jsonStr(j, "endDate");
        dto.projectManager = jsonStr(j, "projectManager");
        dto.budgetAmount = jsonStr(j, "budgetAmount");
        dto.currency = jsonStr(j, "currency");
        dto.createdBy = jsonStr(j, "createdBy");
        auto result = useCase.create(dto);
        if (!result.success) { writeError(res, 400, result.error); return; }
        res.statusCode = cast(int) HTTPStatus.created;
        writeJsonBody(res, Json(["id": Json(result.id)]));
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        ProjectDTO dto;
        dto.id = extractIdFromPath(req.requestPath.to!string);
        dto.programId = jsonStr(j, "programId");
        dto.name = jsonStr(j, "name");
        dto.description = jsonStr(j, "description");
        dto.projectType = jsonStr(j, "projectType");
        dto.status = jsonStr(j, "status");
        dto.startDate = jsonStr(j, "startDate");
        dto.endDate = jsonStr(j, "endDate");
        dto.projectManager = jsonStr(j, "projectManager");
        dto.budgetAmount = jsonStr(j, "budgetAmount");
        dto.currency = jsonStr(j, "currency");
        dto.modifiedBy = jsonStr(j, "modifiedBy");
        auto result = useCase.update(dto);
        if (!result.success) { writeError(res, 404, result.error); return; }
        writeJsonBody(res, Json(["id": Json(result.id)]));
    }

    private void handleDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto result = useCase.remove(id);
        if (!result.success) { writeError(res, 404, result.error); return; }
        res.statusCode = cast(int) HTTPStatus.noContent;
        res.writeBody("");
    }
}
