module uim.software.asset_performance.tests.manage_model_indicator_test;

import uim.software.asset_performance;

@safe unittest {
    auto modelRepo = new MemoryModelRepository();
    auto modelUseCase = new ManageModelsUseCase(modelRepo);

    ModelDTO modelDto;
    modelDto.id = "mdl-test-001";
    modelDto.tenantId = "tenant-test";
    modelDto.name = "Pump Model";
    modelDto.description = "Model for unittest";
    modelDto.manufacturer = "UIM";
    modelDto.version_ = "1.0";
    modelDto.createdBy = "unittest";

    auto createResult = modelUseCase.create(modelDto);
    assert(createResult.success);

    auto listed = modelUseCase.listByTenant("tenant-test");
    assert(listed.length == 1);

    ModelDTO invalidModel;
    invalidModel.id = "mdl-test-invalid";
    invalidModel.tenantId = "tenant-test";
    invalidModel.name = "Broken Model";

    auto invalidResult = modelUseCase.create(invalidModel);
    assert(!invalidResult.success);
}

@safe unittest {
    auto indicatorRepo = new MemoryIndicatorRepository();
    auto indicatorUseCase = new ManageIndicatorsUseCase(indicatorRepo);

    IndicatorDTO invalid;
    invalid.id = "ind-invalid-001";
    invalid.tenantId = "tenant-test";
    invalid.name = "Invalid Indicator";

    auto invalidResult = indicatorUseCase.create(invalid);
    assert(!invalidResult.success);
    assert(invalidResult.error == "Invalid indicator data");

    IndicatorDTO valid;
    valid.id = "ind-valid-001";
    valid.tenantId = "tenant-test";
    valid.equipmentId = "eq-test-001";
    valid.modelId = "mdl-test-001";
    valid.name = "Vibration";
    valid.description = "RMS vibration";
    valid.value_ = "3.1";
    valid.unit = "mm/s";
    valid.thresholdWarning = "4.5";
    valid.thresholdCritical = "6.0";
    valid.measuredAt = "2026-07-09T11:00:00Z";
    valid.createdBy = "unittest";

    auto createResult = indicatorUseCase.create(valid);
    assert(createResult.success);

    auto fetched = indicatorUseCase.get_(valid.id);
    assert(fetched !is null);

    auto removeResult = indicatorUseCase.remove(valid.id);
    assert(removeResult.success);

    auto missingRemove = indicatorUseCase.remove(valid.id);
    assert(!missingRemove.success);
    assert(missingRemove.error == "Indicator not found");
}
