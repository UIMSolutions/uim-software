module uim.platform.content.domain.repositories.content_repository_repository;

import uim.platform.content.domain.entities.content_repository;

@safe:

interface ContentRepositoryRepository {
    ContentRepository[] list();
    const(ContentRepository)* get_(string id);
    bool create(ContentRepository value);
    bool update(ContentRepository value);
    bool remove(string id);
}
