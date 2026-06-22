module uim.platform.ppm.domain.repositories.project_repository;

import uim.platform.ppm.domain.entities.project;
import uim.platform.ppm.domain.types;

@safe:

interface ProjectRepository {
    Project[] findAll();
    Project* findById(ProjectId id);
    void save(Project value);
    void update(Project value);
    void remove(ProjectId id);
}
