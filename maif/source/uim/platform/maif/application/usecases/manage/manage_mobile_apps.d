module uim.platform.maif.application.usecases.manage.manage_mobile_apps;

import std.conv : to;
import std.datetime : Clock;
import uim.platform.maif;

@safe:

class ManageMobileAppsUseCase {
    private MobileAppRepository repo;

    this(MobileAppRepository repo) {
        this.repo = repo;
    }

    MobileApp[] list() {
        return repo.list();
    }

    const(MobileApp)* get_(string id) {
        return repo.get_(id);
    }

    CommandResult create(MobileAppDTO dto) {
        MobileApp value;
        value.id = dto.id.length ? dto.id : createCode("APP");
        value.tenantId = dto.tenantId;
        value.name = dto.name;
        value.description = dto.description;
        value.platform = dto.platform;
        value.versionTag = dto.versionTag;
        value.status = dto.status.length ? dto.status : "draft";
        value.owner = dto.owner;
        value.backendSystem = dto.backendSystem;
        value.authProfile = dto.authProfile;
        value.createdBy = dto.createdBy;
        value.createdAt = Clock.currTime().toISOExtString();

        if (!MaifValidator.isValidMobileApp(value)) {
            return CommandResult(false, "", "Mobile app name and platform are required");
        }

        if (!repo.create(value)) {
            return CommandResult(false, "", "Mobile app already exists");
        }

        return CommandResult(true, value.id, "");
    }

    CommandResult update(MobileAppDTO dto) {
        auto current = repo.get_(dto.id);
        if (current is null) {
            return CommandResult(false, "", "Mobile app not found");
        }

        MobileApp value = *current;
        if (dto.name.length) value.name = dto.name;
        if (dto.description.length) value.description = dto.description;
        if (dto.platform.length) value.platform = dto.platform;
        if (dto.versionTag.length) value.versionTag = dto.versionTag;
        if (dto.status.length) value.status = dto.status;
        if (dto.owner.length) value.owner = dto.owner;
        if (dto.backendSystem.length) value.backendSystem = dto.backendSystem;
        if (dto.authProfile.length) value.authProfile = dto.authProfile;
        value.modifiedBy = dto.modifiedBy;
        value.modifiedAt = Clock.currTime().toISOExtString();

        if (!repo.update(value)) {
            return CommandResult(false, "", "Mobile app not found");
        }

        return CommandResult(true, value.id, "");
    }

    CommandResult remove(string id) {
        if (!repo.remove(id)) {
            return CommandResult(false, "", "Mobile app not found");
        }
        return CommandResult(true, id, "");
    }

    private static string createCode(string prefix) {
        return prefix ~ "-" ~ to!string(Clock.currTime().toUnixTime());
    }
}
