module uim.platform.content.application.usecases.manage.manage_content_repositories;

import std.conv : to;
import std.datetime : Clock;
import uim.platform.content;

@safe:

class ManageContentRepositoriesUseCase {
    private ContentRepositoryRepository repo;

    this(ContentRepositoryRepository repo) {
        this.repo = repo;
    }

    ContentRepository[] list() {
        return repo.list();
    }

    const(ContentRepository)* get_(string id) {
        return repo.get_(id);
    }

    CommandResult create(ContentRepositoryDTO dto) {
        ContentRepository value;
        value.id = dto.id.length ? dto.id : createCode("REP");
        value.tenantId = dto.tenantId;
        value.name = dto.name;
        value.description = dto.description;
        value.storageType = dto.storageType.length ? dto.storageType : "filesystem";
        value.basePath = dto.basePath;
        value.status = dto.status.length ? dto.status : "active";
        value.createdBy = dto.createdBy;
        value.createdAt = Clock.currTime().toISOExtString();

        if (!ContentValidator.isValidRepository(value)) {
            return CommandResult(false, "", "Repository name and storage type are required");
        }

        if (!repo.create(value)) {
            return CommandResult(false, "", "Repository already exists");
        }

        return CommandResult(true, value.id, "");
    }

    CommandResult update(ContentRepositoryDTO dto) {
        auto current = repo.get_(dto.id);
        if (current is null) {
            return CommandResult(false, "", "Repository not found");
        }

        ContentRepository value = *current;
        if (dto.name.length) value.name = dto.name;
        if (dto.description.length) value.description = dto.description;
        if (dto.storageType.length) value.storageType = dto.storageType;
        if (dto.basePath.length) value.basePath = dto.basePath;
        if (dto.status.length) value.status = dto.status;
        value.modifiedBy = dto.modifiedBy;
        value.modifiedAt = Clock.currTime().toISOExtString();

        if (!repo.update(value)) {
            return CommandResult(false, "", "Repository not found");
        }

        return CommandResult(true, value.id, "");
    }

    CommandResult remove(string id) {
        if (!repo.remove(id)) {
            return CommandResult(false, "", "Repository not found");
        }
        return CommandResult(true, id, "");
    }

    private static string createCode(string prefix) {
        return prefix ~ "-" ~ to!string(Clock.currTime().toUnixTime());
    }
}
