module uim.platform.apm.presentation.http.controllers.assessments;

import std.conv : to;
import uim.platform.apm;

@safe:

class AssessmentsController : SAPController {
    private ManageAssessmentsUseCase useCase;

    this(ManageAssessmentsUseCase useCase) { this.useCase = useCase; }

    override void registerRoutes(URLRouter router) {
        router.get("/api/v1/apm/assessments", &handleList);
        router.get("/api/v1/apm/assessments/*", &handleGet);
        router.post("/api/v1/apm/assessments", &handleCreate);
        router.put("/api/v1/apm/assessments/*", &handleUpdate);
        router.delete_("/api/v1/apm/assessments/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto tenantId = req.headers.get("X-Tenant-Id", "");
        auto items = useCase.listByTenant(tenantId);
        auto arr = Json.emptyArray;
        foreach (item; items) arr ~= assessmentToJson(item);
        writeJsonBody(res, Json(["count": Json(cast(long) items.length), "resources": arr]));
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto id = extractIdFromPath(req.requestPath.to!string);
        auto item = useCase.get_(id);
        if (item is null) { writeError(res, 404, "Assessment not found"); return; }
        writeJsonBody(res, assessmentToJson(*item));
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        AssessmentDTO dto;
        dto.id = jsonStr(j, "id");
        dto.tenantId = req.headers.get("X-Tenant-Id", "");
        dto.applicationId = jsonStr(j, "applicationId");
        dto.assessmentDate = jsonStr(j, "assessmentDate");
        dto.assessor = jsonStr(j, "assessor");
        dto.functionalFit = jsonStr(j, "functionalFit");
        dto.technicalFit = jsonStr(j, "technicalFit");
        dto.businessValue = jsonStr(j, "businessValue");
        dto.dataQuality = jsonStr(j, "dataQuality");
        dto.riskNotes = jsonStr(j, "riskNotes");
        dto.nextReviewDate = jsonStr(j, "nextReviewDate");
        dto.createdBy = jsonStr(j, "createdBy");
        dto.createdAt = jsonStr(j, "createdAt");

        auto result = useCase.create(dto);
        if (!result.success) { writeError(res, 400, result.error); return; }

        res.statusCode = cast(int) HTTPStatus.created;
        writeJsonBody(res, Json(["id": Json(result.id)]));
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto j = req.json;
        AssessmentDTO dto;
        dto.id = extractIdFromPath(req.requestPath.to!string);
        dto.assessmentDate = jsonStr(j, "assessmentDate");
        dto.assessor = jsonStr(j, "assessor");
        dto.functionalFit = jsonStr(j, "functionalFit");
        dto.technicalFit = jsonStr(j, "technicalFit");
        dto.businessValue = jsonStr(j, "businessValue");
        dto.dataQuality = jsonStr(j, "dataQuality");
        dto.riskNotes = jsonStr(j, "riskNotes");
        dto.nextReviewDate = jsonStr(j, "nextReviewDate");
        dto.modifiedBy = jsonStr(j, "modifiedBy");
        dto.modifiedAt = jsonStr(j, "modifiedAt");

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
