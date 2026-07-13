module uim.platform.content.domain.repositories.folder_repository;

import uim.platform.content.domain.entities.folder;

@safe:

interface FolderRepository {
    Folder[] list();
    const(Folder)* get_(string id);
    bool create(Folder value);
    bool update(Folder value);
    bool remove(string id);
}
