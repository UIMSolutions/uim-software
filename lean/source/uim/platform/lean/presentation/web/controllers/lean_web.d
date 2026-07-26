module uim.platform.lean.presentation.web.controllers.lean_web;

import std.conv : to;

import uim.platform.lean;

mixin(ShowModule!());

@safe:

class LeanWebController : SAPController {
    private WebInterfaceDefinition[] defs;

    this() {
        defs = defaultWebInterfaceDefinitions();
    }

    override void registerRoutes(URLRouter router) {
        super.registerRoutes(router);
        router.get("/web/lean", &handleHome);
        router.get("/web/lean/*", &handleUseCasePage);
    }

    private void handleHome(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto html = renderLeanWebIndex(defs);
        res.writeBody(html, 200, "text/html; charset=utf-8");
    }

    private void handleUseCasePage(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto key = extractIdFromPath(req.requestURI.to!string);
        if (key.length == 0) {
            handleHome(req, res);
            return;
        }

        foreach (def; defs) {
            if (def.key == key) {
                auto html = renderLeanCrudPage(def);
                res.writeBody(html, 200, "text/html; charset=utf-8");
                return;
            }
        }

        writeError(res, 404, "Unknown LEAN use case page");
    }
}
