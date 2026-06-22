module uim.platform.apm.application.usecases.manage.analyze_portfolio;

import std.conv : to;
import uim.platform.apm;

@safe:

class AnalyzePortfolioUseCase : UIMUseCase {
    private PortfolioItemRepository portfolioItemRepo;
    private AssessmentRepository assessmentRepo;

    this(PortfolioItemRepository portfolioItemRepo, AssessmentRepository assessmentRepo) {
        this.portfolioItemRepo = portfolioItemRepo;
        this.assessmentRepo = assessmentRepo;
    }

    PortfolioMatrixPoint[] matrix(TenantId tenantId = "") {
        auto items = tenantId.length == 0 ? portfolioItemRepo.findAll() : portfolioItemRepo.findByTenant(tenantId);
        auto assessments = tenantId.length == 0 ? assessmentRepo.findAll() : assessmentRepo.findByTenant(tenantId);

        ApplicationAssessment[string] latestByApplication;
        foreach (assessment; assessments) {
            auto existing = assessment.applicationId in latestByApplication;
            if (existing is null || assessment.assessmentDate > (*existing).assessmentDate)
                latestByApplication[assessment.applicationId] = assessment;
        }

        PortfolioMatrixPoint[] points;
        foreach (item; items) {
            auto latest = item.id in latestByApplication;
            if (latest is null)
                continue;

            PortfolioMatrixPoint point;
            point.applicationId = item.id;
            point.applicationName = item.name;
            point.organization = item.organization;
            point.businessCapability = item.businessCapability;
            point.businessCriticality = to!string(item.businessCriticality);
            point.functionalFit = to!string((*latest).functionalFit);
            point.technicalFit = to!string((*latest).technicalFit);
            point.overallScore = (*latest).overallScore;
            point.recommendation = to!string((*latest).recommendation);
            points ~= point;
        }

        return points;
    }

    PortfolioSummaryDTO summary(TenantId tenantId = "") {
        auto items = tenantId.length == 0 ? portfolioItemRepo.findAll() : portfolioItemRepo.findByTenant(tenantId);
        auto assessments = tenantId.length == 0 ? assessmentRepo.findAll() : assessmentRepo.findByTenant(tenantId);

        ApplicationAssessment[string] latestByApplication;
        foreach (assessment; assessments) {
            auto existing = assessment.applicationId in latestByApplication;
            if (existing is null || assessment.assessmentDate > (*existing).assessmentDate)
                latestByApplication[assessment.applicationId] = assessment;
        }

        PortfolioSummaryDTO dto;
        dto.totalApplications = cast(long) items.length;
        dto.totalAssessments = cast(long) assessments.length;
        dto.assessedApplications = cast(long) latestByApplication.length;

        long totalScore = 0;
        foreach (applicationId, assessment; latestByApplication) {
            totalScore += assessment.overallScore;
            final switch (assessment.recommendation) {
                case Recommendation.invest: dto.investCount++; break;
                case Recommendation.tolerate: dto.tolerateCount++; break;
                case Recommendation.migrate: dto.migrateCount++; break;
                case Recommendation.eliminate: dto.eliminateCount++; break;
            }
        }

        if (dto.assessedApplications > 0)
            dto.averageScore = totalScore / dto.assessedApplications;

        return dto;
    }
}
