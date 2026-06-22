module uim.platform.ppm.domain.repositories.program_repository;

import uim.platform.ppm.domain.entities.program;
import uim.platform.ppm.domain.types;

@safe:

interface ProgramRepository {
    Program[] findAll();
    Program* findById(ProgramId id);
    void save(Program value);
    void update(Program value);
    void remove(ProgramId id);
}
