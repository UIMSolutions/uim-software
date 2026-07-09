module uim.software.asset_performance.infrastructure.seed;

import uim.software.asset_performance;

mixin(ShowModule!());

@safe:

struct DemoSeedResult {
    size_t inserted;
    size_t skipped;
}

DemoSeedResult seedDemoData(Container container, string tenantId = "demo-tenant") {
    DemoSeedResult result;

    if (container.manageModelsUseCase.get_("mdl-pump-001") is null) {
        ModelDTO model;
        model.id = "mdl-pump-001";
        model.tenantId = tenantId;
        model.name = "Centrifugal Pump Class";
        model.description = "Class-level definition for centrifugal process pumps.";
        model.manufacturer = "UIM Industrial";
        model.version_ = "1.0.0";
        model.modelNumber = "CP-100";
        model.templateId = "tmpl-risk-criticality-01";
        model.isoStandard = "ISO 14224";
        model.isPublished = true;
        model.createdBy = "seed-service";
        auto createResult = container.manageModelsUseCase.create(model);
        if (createResult.success) result.inserted++; else result.skipped++;
    } else {
        result.skipped++;
    }

    if (container.manageLocationsUseCase.get_("loc-plant-a-unit-1") is null) {
        LocationDTO location;
        location.id = "loc-plant-a-unit-1";
        location.tenantId = tenantId;
        location.name = "Plant A - Unit 1";
        location.description = "Primary process unit for demo scenario.";
        location.address = "Industrial Zone 7";
        location.building = "A";
        location.floor = "1";
        location.room = "Pump Gallery";
        location.createdBy = "seed-service";
        auto createResult = container.manageLocationsUseCase.create(location);
        if (createResult.success) result.inserted++; else result.skipped++;
    } else {
        result.skipped++;
    }

    if (container.manageEquipmentUseCase.get_("eq-pump-1001") is null) {
        EquipmentDTO equipment;
        equipment.id = "eq-pump-1001";
        equipment.tenantId = tenantId;
        equipment.modelId = "mdl-pump-001";
        equipment.locationId = "loc-plant-a-unit-1";
        equipment.serialNumber = "SN-CP-1001";
        equipment.name = "Feed Pump P-1001";
        equipment.description = "Critical feed pump for line 1.";
        equipment.manufacturer = "UIM Industrial";
        equipment.operatorId = "ops-team-a";
        equipment.installationDate = "2026-01-15";
        equipment.commissioningDate = "2026-02-01";
        equipment.warrantyEndDate = "2028-02-01";
        equipment.criticality = "High";
        equipment.maintenanceStrategy = "Risk-based + condition monitoring";
        equipment.lastMaintenanceDate = "2026-06-10";
        equipment.nextMaintenanceDate = "2026-09-10";
        equipment.firmwareVersion = "3.2.4";
        equipment.createdBy = "seed-service";
        auto createResult = container.manageEquipmentUseCase.create(equipment);
        if (createResult.success) result.inserted++; else result.skipped++;
    } else {
        result.skipped++;
    }

    if (container.manageFailureModesUseCase.get_("fm-seal-leak") is null) {
        FailureModeDTO failureMode;
        failureMode.id = "fm-seal-leak";
        failureMode.tenantId = tenantId;
        failureMode.modelId = "mdl-pump-001";
        failureMode.equipmentId = "eq-pump-1001";
        failureMode.name = "Mechanical Seal Leak";
        failureMode.description = "Leakage due to worn seal faces.";
        failureMode.cause = "Abrasive particles and thermal cycling";
        failureMode.effect = "Loss of containment and pump shutdown risk";
        failureMode.detection = "Pressure and vibration deviation";
        failureMode.mitigation = "Planned seal replacement and filtration";
        failureMode.riskPriorityNumber = "168";
        failureMode.occurrenceProbability = "4";
        failureMode.detectability = "7";
        failureMode.createdBy = "seed-service";
        auto createResult = container.manageFailureModesUseCase.create(failureMode);
        if (createResult.success) result.inserted++; else result.skipped++;
    } else {
        result.skipped++;
    }

    if (container.manageAssessmentsUseCase.get_("asm-risk-1001") is null) {
        AssessmentDTO assessment;
        assessment.id = "asm-risk-1001";
        assessment.tenantId = tenantId;
        assessment.equipmentId = "eq-pump-1001";
        assessment.modelId = "mdl-pump-001";
        assessment.locationId = "loc-plant-a-unit-1";
        assessment.name = "Pump P-1001 Risk Criticality";
        assessment.description = "Risk/criticality segmentation for maintenance prioritization.";
        assessment.assessmentType = "riskCriticality";
        assessment.status = "completed";
        assessment.templateId = "tmpl-risk-criticality-01";
        assessment.score = "82";
        assessment.riskLevel = "High";
        assessment.likelihood = "Medium";
        assessment.consequence = "High";
        assessment.assessedBy = "reliability.engineer";
        assessment.approvedBy = "maintenance.manager";
        assessment.assessmentDate = "2026-07-01";
        assessment.nextReviewDate = "2026-10-01";
        assessment.createdBy = "seed-service";
        auto createResult = container.manageAssessmentsUseCase.create(assessment);
        if (createResult.success) result.inserted++; else result.skipped++;
    } else {
        result.skipped++;
    }

    if (container.manageInstructionsUseCase.get_("ins-maint-1001") is null) {
        InstructionDTO instruction;
        instruction.id = "ins-maint-1001";
        instruction.tenantId = tenantId;
        instruction.modelId = "mdl-pump-001";
        instruction.equipmentId = "eq-pump-1001";
        instruction.name = "Quarterly Pump Seal Inspection";
        instruction.description = "Inspection and preventive replacement workflow.";
        instruction.instructionType = "inspection";
        instruction.priority = "high";
        instruction.version_ = "1.0";
        instruction.steps = "Isolate, inspect seal, measure wear, replace if threshold exceeded";
        instruction.safetyNotes = "Use lockout-tagout and PPE";
        instruction.requiredTools = "Torque wrench, laser alignment kit";
        instruction.estimatedDuration = "90m";
        instruction.publishedBy = "maintenance.manager";
        instruction.effectiveDate = "2026-07-05";
        instruction.createdBy = "seed-service";
        auto createResult = container.manageInstructionsUseCase.create(instruction);
        if (createResult.success) result.inserted++; else result.skipped++;
    } else {
        result.skipped++;
    }

    if (container.manageFunctionsUseCase.get_("fn-feed-transfer") is null) {
        FunctionDTO functionDto;
        functionDto.id = "fn-feed-transfer";
        functionDto.tenantId = tenantId;
        functionDto.equipmentId = "eq-pump-1001";
        functionDto.modelId = "mdl-pump-001";
        functionDto.locationId = "loc-plant-a-unit-1";
        functionDto.name = "Feed Transfer Function";
        functionDto.description = "Transfer feedstock at rated flow and pressure.";
        functionDto.status = "operational";
        functionDto.operatingContext = "24x7 process duty";
        functionDto.performanceStandard = "Flow >= 500 m3/h at 6 bar";
        functionDto.failureDefinition = "Flow < 460 m3/h for 10 min";
        functionDto.redundancy = "N+1 standby pump";
        functionDto.createdBy = "seed-service";
        auto createResult = container.manageFunctionsUseCase.create(functionDto);
        if (createResult.success) result.inserted++; else result.skipped++;
    } else {
        result.skipped++;
    }

    if (container.manageIndicatorsUseCase.get_("ind-vibration-1001") is null) {
        IndicatorDTO indicator;
        indicator.id = "ind-vibration-1001";
        indicator.tenantId = tenantId;
        indicator.equipmentId = "eq-pump-1001";
        indicator.modelId = "mdl-pump-001";
        indicator.name = "Bearing Vibration";
        indicator.description = "Online vibration indicator used for condition monitoring.";
        indicator.indicatorType = "vibration";
        indicator.status = "normal";
        indicator.value_ = "3.2";
        indicator.unit = "mm/s";
        indicator.thresholdWarning = "4.5";
        indicator.thresholdCritical = "6.0";
        indicator.measuredAt = "2026-07-09T10:00:00Z";
        indicator.createdBy = "seed-service";
        auto createResult = container.manageIndicatorsUseCase.create(indicator);
        if (createResult.success) result.inserted++; else result.skipped++;
    } else {
        result.skipped++;
    }

    return result;
}