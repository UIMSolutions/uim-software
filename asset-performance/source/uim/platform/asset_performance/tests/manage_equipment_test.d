module uim.software.asset_performance.tests.manage_equipment_test;

import uim.software.asset_performance;

@safe unittest {
    auto repo = new MemoryEquipmentRepository();
    auto useCase = new ManageEquipmentUseCase(repo);

    EquipmentDTO dto;
    dto.id = "eq-test-001";
    dto.tenantId = "tenant-test";
    dto.modelId = "mdl-test-001";
    dto.locationId = "loc-test-001";
    dto.serialNumber = "SN-TEST-001";
    dto.name = "Test Equipment";
    dto.description = "Equipment created in unittest";
    dto.manufacturer = "UIM";
    dto.createdBy = "unittest";

    auto createResult = useCase.create(dto);
    assert(createResult.success);
    assert(createResult.id == dto.id);

    auto allItems = useCase.list();
    assert(allItems.length == 1);

    auto fetched = useCase.get_(dto.id);
    assert(fetched !is null);
    assert(fetched.id == dto.id);

    EquipmentDTO updateDto;
    updateDto.id = dto.id;
    updateDto.name = "Test Equipment Updated";
    updateDto.description = "Updated description";
    updateDto.maintenanceStrategy = "Condition-based";
    updateDto.modifiedBy = "unittest";

    auto updateResult = useCase.update(updateDto);
    assert(updateResult.success);

    fetched = useCase.get_(dto.id);
    assert(fetched !is null);
    assert(fetched.name == "Test Equipment Updated");
    assert(fetched.maintenanceStrategy == "Condition-based");

    auto removeResult = useCase.remove(dto.id);
    assert(removeResult.success);
    assert(useCase.list().length == 0);
}

@safe unittest {
    auto repo = new MemoryEquipmentRepository();
    auto useCase = new ManageEquipmentUseCase(repo);

    EquipmentDTO invalidDto;
    invalidDto.id = "eq-test-invalid";
    invalidDto.tenantId = "tenant-test";
    invalidDto.name = "Invalid Equipment";
    invalidDto.createdBy = "unittest";

    auto createResult = useCase.create(invalidDto);
    assert(!createResult.success);
    assert(createResult.error.length > 0);

    auto removeResult = useCase.remove("missing-id");
    assert(!removeResult.success);
    assert(removeResult.error == "Equipment not found");
}
