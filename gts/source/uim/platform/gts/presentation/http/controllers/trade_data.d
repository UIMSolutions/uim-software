module uim.platform.gts.presentation.http.controllers.trade_data;

import std.conv : to;

import uim.platform.gts;

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

class BusinessPartnerController : SAPController {
    private ManageBusinessPartnersUseCase uc;

    this(ManageBusinessPartnersUseCase uc) { this.uc = uc; }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/api/v1/gts/business-partners", &handleList);
        router.get("/api/v1/gts/business-partners/*", &handleGet);
        router.post("/api/v1/gts/business-partners", &handleCreate);
        router.put("/api/v1/gts/business-partners/*", &handleUpdate);
        router.delete_("/api/v1/gts/business-partners/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try res.writeJsonBody(listResponse(uc.list(), &businessPartnerToJson), 200);
        catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto id = extractIdFromPath(req.requestURI.to!string);
            auto value = uc.get_(id);
            if (value is null) { writeError(res, 404, "Business partner not found"); return; }
            res.writeJsonBody(businessPartnerToJson(*value), 200);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            BusinessPartnerDTO dto;
            dto.id = jsonStr(j, "id");
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.name = jsonStr(j, "name");
            dto.partnerRole = jsonStr(j, "partnerRole");
            dto.country = jsonStr(j, "country");
            dto.vatNumber = jsonStr(j, "vatNumber");
            dto.status = jsonStr(j, "status");
            dto.createdBy = jsonStr(j, "createdBy");

            auto result = uc.create(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Business partner created");
                res.writeJsonBody(body, 201);
            } else writeError(res, 400, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            BusinessPartnerDTO dto;
            dto.id = extractIdFromPath(req.requestURI.to!string);
            dto.name = jsonStr(j, "name");
            dto.partnerRole = jsonStr(j, "partnerRole");
            dto.country = jsonStr(j, "country");
            dto.vatNumber = jsonStr(j, "vatNumber");
            dto.status = jsonStr(j, "status");
            dto.modifiedBy = jsonStr(j, "modifiedBy");

            auto result = uc.update(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Business partner updated");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto result = uc.remove(extractIdFromPath(req.requestURI.to!string));
            if (result.success) {
                auto body = Json.emptyObject;
                body["message"] = Json("Business partner deleted");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }
}

class ProductClassificationController : SAPController {
    private ManageProductClassificationsUseCase uc;

    this(ManageProductClassificationsUseCase uc) { this.uc = uc; }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/api/v1/gts/product-classifications", &handleList);
        router.get("/api/v1/gts/product-classifications/*", &handleGet);
        router.post("/api/v1/gts/product-classifications", &handleCreate);
        router.put("/api/v1/gts/product-classifications/*", &handleUpdate);
        router.delete_("/api/v1/gts/product-classifications/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try res.writeJsonBody(listResponse(uc.list(), &productClassificationToJson), 200);
        catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto value = uc.get_(extractIdFromPath(req.requestURI.to!string));
            if (value is null) { writeError(res, 404, "Product classification not found"); return; }
            res.writeJsonBody(productClassificationToJson(*value), 200);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            ProductClassificationDTO dto;
            dto.id = jsonStr(j, "id");
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.productId = jsonStr(j, "productId");
            dto.description = jsonStr(j, "description");
            dto.commodityCode = jsonStr(j, "commodityCode");
            dto.exportControlClass = jsonStr(j, "exportControlClass");
            dto.originCountry = jsonStr(j, "originCountry");
            dto.status = jsonStr(j, "status");
            dto.createdBy = jsonStr(j, "createdBy");

            auto result = uc.create(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Product classification created");
                res.writeJsonBody(body, 201);
            } else writeError(res, 400, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            ProductClassificationDTO dto;
            dto.id = extractIdFromPath(req.requestURI.to!string);
            dto.description = jsonStr(j, "description");
            dto.commodityCode = jsonStr(j, "commodityCode");
            dto.exportControlClass = jsonStr(j, "exportControlClass");
            dto.originCountry = jsonStr(j, "originCountry");
            dto.status = jsonStr(j, "status");
            dto.modifiedBy = jsonStr(j, "modifiedBy");

            auto result = uc.update(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Product classification updated");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto result = uc.remove(extractIdFromPath(req.requestURI.to!string));
            if (result.success) {
                auto body = Json.emptyObject;
                body["message"] = Json("Product classification deleted");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }
}

class CustomsDeclarationController : SAPController {
    private ManageCustomsDeclarationsUseCase uc;

    this(ManageCustomsDeclarationsUseCase uc) { this.uc = uc; }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/api/v1/gts/customs-declarations", &handleList);
        router.get("/api/v1/gts/customs-declarations/*", &handleGet);
        router.post("/api/v1/gts/customs-declarations", &handleCreate);
        router.put("/api/v1/gts/customs-declarations/*", &handleUpdate);
        router.delete_("/api/v1/gts/customs-declarations/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try res.writeJsonBody(listResponse(uc.list(), &customsDeclarationToJson), 200);
        catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto value = uc.get_(extractIdFromPath(req.requestURI.to!string));
            if (value is null) { writeError(res, 404, "Customs declaration not found"); return; }
            res.writeJsonBody(customsDeclarationToJson(*value), 200);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            CustomsDeclarationDTO dto;
            dto.id = jsonStr(j, "id");
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.flow = jsonStr(j, "flow");
            dto.declarationNumber = jsonStr(j, "declarationNumber");
            dto.partnerId = jsonStr(j, "partnerId");
            dto.productId = jsonStr(j, "productId");
            dto.customsOffice = jsonStr(j, "customsOffice");
            dto.declarationDate = jsonStr(j, "declarationDate");
            dto.procedureCode = jsonStr(j, "procedureCode");
            dto.totalValue = jsonStr(j, "totalValue");
            dto.currency = jsonStr(j, "currency");
            dto.status = jsonStr(j, "status");
            dto.createdBy = jsonStr(j, "createdBy");

            auto result = uc.create(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Customs declaration created");
                res.writeJsonBody(body, 201);
            } else writeError(res, 400, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            CustomsDeclarationDTO dto;
            dto.id = extractIdFromPath(req.requestURI.to!string);
            dto.flow = jsonStr(j, "flow");
            dto.declarationNumber = jsonStr(j, "declarationNumber");
            dto.customsOffice = jsonStr(j, "customsOffice");
            dto.procedureCode = jsonStr(j, "procedureCode");
            dto.totalValue = jsonStr(j, "totalValue");
            dto.currency = jsonStr(j, "currency");
            dto.status = jsonStr(j, "status");
            dto.modifiedBy = jsonStr(j, "modifiedBy");

            auto result = uc.update(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Customs declaration updated");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto result = uc.remove(extractIdFromPath(req.requestURI.to!string));
            if (result.success) {
                auto body = Json.emptyObject;
                body["message"] = Json("Customs declaration deleted");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }
}

class TradeLicenseController : SAPController {
    private ManageTradeLicensesUseCase uc;

    this(ManageTradeLicensesUseCase uc) { this.uc = uc; }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/api/v1/gts/trade-licenses", &handleList);
        router.get("/api/v1/gts/trade-licenses/*", &handleGet);
        router.post("/api/v1/gts/trade-licenses", &handleCreate);
        router.put("/api/v1/gts/trade-licenses/*", &handleUpdate);
        router.delete_("/api/v1/gts/trade-licenses/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try res.writeJsonBody(listResponse(uc.list(), &tradeLicenseToJson), 200);
        catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto value = uc.get_(extractIdFromPath(req.requestURI.to!string));
            if (value is null) { writeError(res, 404, "Trade license not found"); return; }
            res.writeJsonBody(tradeLicenseToJson(*value), 200);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            TradeLicenseDTO dto;
            dto.id = jsonStr(j, "id");
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.licenseType = jsonStr(j, "licenseType");
            dto.licenseNumber = jsonStr(j, "licenseNumber");
            dto.issuingAuthority = jsonStr(j, "issuingAuthority");
            dto.validFrom = jsonStr(j, "validFrom");
            dto.validTo = jsonStr(j, "validTo");
            dto.partnerId = jsonStr(j, "partnerId");
            dto.country = jsonStr(j, "country");
            dto.status = jsonStr(j, "status");
            dto.createdBy = jsonStr(j, "createdBy");

            auto result = uc.create(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Trade license created");
                res.writeJsonBody(body, 201);
            } else writeError(res, 400, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            TradeLicenseDTO dto;
            dto.id = extractIdFromPath(req.requestURI.to!string);
            dto.licenseType = jsonStr(j, "licenseType");
            dto.licenseNumber = jsonStr(j, "licenseNumber");
            dto.issuingAuthority = jsonStr(j, "issuingAuthority");
            dto.validFrom = jsonStr(j, "validFrom");
            dto.validTo = jsonStr(j, "validTo");
            dto.country = jsonStr(j, "country");
            dto.status = jsonStr(j, "status");
            dto.modifiedBy = jsonStr(j, "modifiedBy");

            auto result = uc.update(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Trade license updated");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto result = uc.remove(extractIdFromPath(req.requestURI.to!string));
            if (result.success) {
                auto body = Json.emptyObject;
                body["message"] = Json("Trade license deleted");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }
}

class PreferenceAgreementController : SAPController {
    private ManagePreferenceAgreementsUseCase uc;

    this(ManagePreferenceAgreementsUseCase uc) { this.uc = uc; }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/api/v1/gts/preference-agreements", &handleList);
        router.get("/api/v1/gts/preference-agreements/*", &handleGet);
        router.post("/api/v1/gts/preference-agreements", &handleCreate);
        router.put("/api/v1/gts/preference-agreements/*", &handleUpdate);
        router.delete_("/api/v1/gts/preference-agreements/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try res.writeJsonBody(listResponse(uc.list(), &preferenceAgreementToJson), 200);
        catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto value = uc.get_(extractIdFromPath(req.requestURI.to!string));
            if (value is null) { writeError(res, 404, "Preference agreement not found"); return; }
            res.writeJsonBody(preferenceAgreementToJson(*value), 200);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            PreferenceAgreementDTO dto;
            dto.id = jsonStr(j, "id");
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.scheme = jsonStr(j, "scheme");
            dto.agreementCode = jsonStr(j, "agreementCode");
            dto.beneficiaryCountry = jsonStr(j, "beneficiaryCountry");
            dto.originRule = jsonStr(j, "originRule");
            dto.validFrom = jsonStr(j, "validFrom");
            dto.validTo = jsonStr(j, "validTo");
            dto.status = jsonStr(j, "status");
            dto.createdBy = jsonStr(j, "createdBy");

            auto result = uc.create(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Preference agreement created");
                res.writeJsonBody(body, 201);
            } else writeError(res, 400, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            PreferenceAgreementDTO dto;
            dto.id = extractIdFromPath(req.requestURI.to!string);
            dto.scheme = jsonStr(j, "scheme");
            dto.beneficiaryCountry = jsonStr(j, "beneficiaryCountry");
            dto.originRule = jsonStr(j, "originRule");
            dto.validFrom = jsonStr(j, "validFrom");
            dto.validTo = jsonStr(j, "validTo");
            dto.status = jsonStr(j, "status");
            dto.modifiedBy = jsonStr(j, "modifiedBy");

            auto result = uc.update(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Preference agreement updated");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto result = uc.remove(extractIdFromPath(req.requestURI.to!string));
            if (result.success) {
                auto body = Json.emptyObject;
                body["message"] = Json("Preference agreement deleted");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }
}

class SanctionedPartyCaseController : SAPController {
    private ManageSanctionedPartyCasesUseCase uc;

    this(ManageSanctionedPartyCasesUseCase uc) { this.uc = uc; }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/api/v1/gts/sanctioned-party-cases", &handleList);
        router.get("/api/v1/gts/sanctioned-party-cases/*", &handleGet);
        router.post("/api/v1/gts/sanctioned-party-cases", &handleCreate);
        router.put("/api/v1/gts/sanctioned-party-cases/*", &handleUpdate);
        router.delete_("/api/v1/gts/sanctioned-party-cases/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try res.writeJsonBody(listResponse(uc.list(), &sanctionedPartyCaseToJson), 200);
        catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto value = uc.get_(extractIdFromPath(req.requestURI.to!string));
            if (value is null) { writeError(res, 404, "Sanctioned party case not found"); return; }
            res.writeJsonBody(sanctionedPartyCaseToJson(*value), 200);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            SanctionedPartyCaseDTO dto;
            dto.id = jsonStr(j, "id");
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.partnerName = jsonStr(j, "partnerName");
            dto.matchCode = jsonStr(j, "matchCode");
            dto.risk = jsonStr(j, "risk");
            dto.reviewedBy = jsonStr(j, "reviewedBy");
            dto.reviewDate = jsonStr(j, "reviewDate");
            dto.status = jsonStr(j, "status");
            dto.decisionReason = jsonStr(j, "decisionReason");
            dto.createdBy = jsonStr(j, "createdBy");

            auto result = uc.create(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Sanctioned party case created");
                res.writeJsonBody(body, 201);
            } else writeError(res, 400, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            SanctionedPartyCaseDTO dto;
            dto.id = extractIdFromPath(req.requestURI.to!string);
            dto.matchCode = jsonStr(j, "matchCode");
            dto.risk = jsonStr(j, "risk");
            dto.reviewedBy = jsonStr(j, "reviewedBy");
            dto.reviewDate = jsonStr(j, "reviewDate");
            dto.status = jsonStr(j, "status");
            dto.decisionReason = jsonStr(j, "decisionReason");
            dto.modifiedBy = jsonStr(j, "modifiedBy");

            auto result = uc.update(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Sanctioned party case updated");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto result = uc.remove(extractIdFromPath(req.requestURI.to!string));
            if (result.success) {
                auto body = Json.emptyObject;
                body["message"] = Json("Sanctioned party case deleted");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }
}

class EmbargoControlCaseController : SAPController {
    private ManageEmbargoControlCasesUseCase uc;

    this(ManageEmbargoControlCasesUseCase uc) { this.uc = uc; }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/api/v1/gts/embargo-control-cases", &handleList);
        router.get("/api/v1/gts/embargo-control-cases/*", &handleGet);
        router.post("/api/v1/gts/embargo-control-cases", &handleCreate);
        router.put("/api/v1/gts/embargo-control-cases/*", &handleUpdate);
        router.delete_("/api/v1/gts/embargo-control-cases/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try res.writeJsonBody(listResponse(uc.list(), &embargoControlCaseToJson), 200);
        catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto value = uc.get_(extractIdFromPath(req.requestURI.to!string));
            if (value is null) { writeError(res, 404, "Embargo control case not found"); return; }
            res.writeJsonBody(embargoControlCaseToJson(*value), 200);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            EmbargoControlCaseDTO dto;
            dto.id = jsonStr(j, "id");
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.destinationCountry = jsonStr(j, "destinationCountry");
            dto.productId = jsonStr(j, "productId");
            dto.embargoRegulation = jsonStr(j, "embargoRegulation");
            dto.risk = jsonStr(j, "risk");
            dto.status = jsonStr(j, "status");
            dto.reviewedBy = jsonStr(j, "reviewedBy");
            dto.decisionDate = jsonStr(j, "decisionDate");
            dto.decisionReason = jsonStr(j, "decisionReason");
            dto.createdBy = jsonStr(j, "createdBy");

            auto result = uc.create(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Embargo control case created");
                res.writeJsonBody(body, 201);
            } else writeError(res, 400, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            EmbargoControlCaseDTO dto;
            dto.id = extractIdFromPath(req.requestURI.to!string);
            dto.destinationCountry = jsonStr(j, "destinationCountry");
            dto.embargoRegulation = jsonStr(j, "embargoRegulation");
            dto.risk = jsonStr(j, "risk");
            dto.status = jsonStr(j, "status");
            dto.reviewedBy = jsonStr(j, "reviewedBy");
            dto.decisionDate = jsonStr(j, "decisionDate");
            dto.decisionReason = jsonStr(j, "decisionReason");
            dto.modifiedBy = jsonStr(j, "modifiedBy");

            auto result = uc.update(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Embargo control case updated");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto result = uc.remove(extractIdFromPath(req.requestURI.to!string));
            if (result.success) {
                auto body = Json.emptyObject;
                body["message"] = Json("Embargo control case deleted");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }
}

class IntrastatDeclarationController : SAPController {
    private ManageIntrastatDeclarationsUseCase uc;

    this(ManageIntrastatDeclarationsUseCase uc) { this.uc = uc; }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/api/v1/gts/intrastat-declarations", &handleList);
        router.get("/api/v1/gts/intrastat-declarations/*", &handleGet);
        router.post("/api/v1/gts/intrastat-declarations", &handleCreate);
        router.put("/api/v1/gts/intrastat-declarations/*", &handleUpdate);
        router.delete_("/api/v1/gts/intrastat-declarations/*", &handleDelete);
    }

    private void handleList(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try res.writeJsonBody(listResponse(uc.list(), &intrastatDeclarationToJson), 200);
        catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleGet(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto value = uc.get_(extractIdFromPath(req.requestURI.to!string));
            if (value is null) { writeError(res, 404, "Intrastat declaration not found"); return; }
            res.writeJsonBody(intrastatDeclarationToJson(*value), 200);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleCreate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            IntrastatDeclarationDTO dto;
            dto.id = jsonStr(j, "id");
            dto.tenantId = req.headers.get("X-Tenant-Id", "");
            dto.reportingPeriod = jsonStr(j, "reportingPeriod");
            dto.dispatchCountry = jsonStr(j, "dispatchCountry");
            dto.arrivalCountry = jsonStr(j, "arrivalCountry");
            dto.commodityCode = jsonStr(j, "commodityCode");
            dto.netMass = jsonStr(j, "netMass");
            dto.supplementaryUnits = jsonStr(j, "supplementaryUnits");
            dto.statisticalValue = jsonStr(j, "statisticalValue");
            dto.currency = jsonStr(j, "currency");
            dto.status = jsonStr(j, "status");
            dto.createdBy = jsonStr(j, "createdBy");

            auto result = uc.create(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Intrastat declaration created");
                res.writeJsonBody(body, 201);
            } else writeError(res, 400, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleUpdate(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto j = req.json;
            IntrastatDeclarationDTO dto;
            dto.id = extractIdFromPath(req.requestURI.to!string);
            dto.reportingPeriod = jsonStr(j, "reportingPeriod");
            dto.dispatchCountry = jsonStr(j, "dispatchCountry");
            dto.arrivalCountry = jsonStr(j, "arrivalCountry");
            dto.commodityCode = jsonStr(j, "commodityCode");
            dto.netMass = jsonStr(j, "netMass");
            dto.supplementaryUnits = jsonStr(j, "supplementaryUnits");
            dto.statisticalValue = jsonStr(j, "statisticalValue");
            dto.currency = jsonStr(j, "currency");
            dto.status = jsonStr(j, "status");
            dto.modifiedBy = jsonStr(j, "modifiedBy");

            auto result = uc.update(dto);
            if (result.success) {
                auto body = Json.emptyObject;
                body["id"] = Json(result.id);
                body["message"] = Json("Intrastat declaration updated");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }

    private void handleDelete(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        try {
            auto result = uc.remove(extractIdFromPath(req.requestURI.to!string));
            if (result.success) {
                auto body = Json.emptyObject;
                body["message"] = Json("Intrastat declaration deleted");
                res.writeJsonBody(body, 200);
            } else writeError(res, 404, result.error);
        } catch (Exception ex) writeError(res, 500, "Internal server error");
    }
}
