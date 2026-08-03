module uim.platform.material_traceability.presentation.http.controllers.auth;

import std.algorithm.searching : canFind;
import std.array : split;
import std.string : strip;
import uim.platform.material_traceability;

@safe:

struct AuthGuard {
    static bool ensureRead(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        auto auth = req.headers.get("Authorization", "");
        if (auth.length == 0) {
            writeError(res, 401, "Missing Authorization header");
            return false;
        }
        if (auth.length < 8 || auth[0 .. 7] != "Bearer ") {
            writeError(res, 401, "Authorization must use Bearer token");
            return false;
        }
        return true;
    }

    static bool ensureWrite(scope HTTPServerRequest req, scope HTTPServerResponse res, string objectType) {
        if (!ensureRead(req, res)) {
            return false;
        }

        auto rolesHeader = req.headers.get("X-MT-Roles", "");
        auto roles = parseRoles(rolesHeader);

        if (roles.canFind("mt.admin") || roles.canFind("mt.write") || roles.canFind(objectType ~ ".write")) {
            return true;
        }

        writeError(res, 403, "Missing required write role");
        return false;
    }

    private static string[] parseRoles(string rawRoles) {
        string[] roles;
        foreach (part; rawRoles.split(",")) {
            auto role = strip(part);
            if (role.length) {
                roles ~= role;
            }
        }
        return roles;
    }
}
