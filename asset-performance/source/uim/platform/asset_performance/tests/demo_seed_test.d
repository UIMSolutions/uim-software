module uim.software.asset_performance.tests.demo_seed_test;

import uim.software.asset_performance;

@safe unittest {
    AppConfig config;
    auto container = buildContainer(config);

    auto firstSeed = seedDemoData(container, "tenant-seed-test");
    assert(firstSeed.inserted > 0);

    auto secondSeed = seedDemoData(container, "tenant-seed-test");
    assert(secondSeed.inserted == 0);
    assert(secondSeed.skipped >= firstSeed.inserted);

    assert(container.manageEquipmentUseCase.get_("eq-pump-1001") !is null);
    assert(container.manageModelsUseCase.get_("mdl-pump-001") !is null);
    assert(container.manageLocationsUseCase.get_("loc-plant-a-unit-1") !is null);
    assert(container.manageIndicatorsUseCase.get_("ind-vibration-1001") !is null);
}
