module uim.platform.content.application.usecases.manage.manage_folders;

import std.conv : to;
import std.datetime : Clock;
import uim.platform.content;

@safe:

class ManageFoldersUseCase {
    private FolderRepository folderRepo;
    private ContentRepositoryRepository repositoryRepo;

    this(FolderRepository folderRepo, ContentRepositoryRepository repositoryRepo) {
        this.folderRepo = folderRepo;
        this.repositoryRepo = repositoryRepo;
    }

    Folder[] list() {
        return folderRepo.list();
    }

    const(Folder)* get_(string id) {
        return folderRepo.get_(id);
    }

    CommandResult create(FolderDTO dto) {
        if (repositoryRepo.get_(dto.repositoryId) is null) {
            return CommandResult(false, "", "Repository not found");
        }

        Folder value;
        value.id = dto.id.length ? dto.id : createCode("FLD");
        value.tenantId = dto.tenantId;
        value.repositoryId = dto.repositoryId;
        value.parentFolderId = dto.parentFolderId;
        value.name = dto.name;
        value.path = dto.path.length ? dto.path : "/" ~ dto.name;
        value.description = dto.description;
        value.status = dto.status.length ? dto.status : "active";
        value.createdBy = dto.createdBy;
        value.createdAt = Clock.currTime().toISOExtString();

        if (!ContentValidator.isValidFolder(value)) {
            return CommandResult(false, "", "Folder repositoryId and name are required");
        }

        if (!folderRepo.create(value)) {
            return CommandResult(false, "", "Folder already exists");
        }

        return CommandResult(true, value.id, "");
    }

    CommandResult update(FolderDTO dto) {
        auto current = folderRepo.get_(dto.id);
        if (current is null) {
            return CommandResult(false, "", "Folder not found");
        }

        Folder value = *current;
        if (dto.repositoryId.length) value.repositoryId = dto.repositoryId;
        if (dto.parentFolderId.length) value.parentFolderId = dto.parentFolderId;
        if (dto.name.length) value.name = dto.name;
        if (dto.path.length) value.path = dto.path;
        if (dto.description.length) value.description = dto.description;
        if (dto.status.length) value.status = dto.status;
        value.modifiedBy = dto.modifiedBy;
        value.modifiedAt = Clock.currTime().toISOExtString();

        if (!folderRepo.update(value)) {
            return CommandResult(false, "", "Folder not found");
        }

        return CommandResult(true, value.id, "");
    }

    CommandResult remove(string id) {
        if (!folderRepo.remove(id)) {
            return CommandResult(false, "", "Folder not found");
        }
        return CommandResult(true, id, "");
    }

    private static string createCode(string prefix) {
        return prefix ~ "-" ~ to!string(Clock.currTime().toUnixTime());
    }
}
