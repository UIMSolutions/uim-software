module uim.platform.alm.domain.services;

import std.conv : to;

import uim.platform.alm.domain.types;

@safe:

struct AlmPolicy {
    static SolutionLifecycleStage parseLifecycleStage(
        string value,
        SolutionLifecycleStage fallback = SolutionLifecycleStage.explore
    ) {
        if (value.length == 0)
            return fallback;
        try return value.to!SolutionLifecycleStage;
        catch (Exception) return fallback;
    }

    static ProjectStatus parseProjectStatus(string value, ProjectStatus fallback = ProjectStatus.planned) {
        if (value.length == 0)
            return fallback;
        try return value.to!ProjectStatus;
        catch (Exception) return fallback;
    }

    static TaskStatus parseTaskStatus(string value, TaskStatus fallback = TaskStatus.backlog) {
        if (value.length == 0)
            return fallback;
        try return value.to!TaskStatus;
        catch (Exception) return fallback;
    }

    static TestPlanStatus parseTestPlanStatus(string value, TestPlanStatus fallback = TestPlanStatus.draft) {
        if (value.length == 0)
            return fallback;
        try return value.to!TestPlanStatus;
        catch (Exception) return fallback;
    }

    static TestCaseStatus parseTestCaseStatus(string value, TestCaseStatus fallback = TestCaseStatus.draft) {
        if (value.length == 0)
            return fallback;
        try return value.to!TestCaseStatus;
        catch (Exception) return fallback;
    }

    static DefectSeverity parseDefectSeverity(string value, DefectSeverity fallback = DefectSeverity.medium) {
        if (value.length == 0)
            return fallback;
        try return value.to!DefectSeverity;
        catch (Exception) return fallback;
    }

    static DefectStatus parseDefectStatus(string value, DefectStatus fallback = DefectStatus.new_) {
        if (value.length == 0)
            return fallback;
        try return value.to!DefectStatus;
        catch (Exception) return fallback;
    }

    static ReleaseStatus parseReleaseStatus(string value, ReleaseStatus fallback = ReleaseStatus.draft) {
        if (value.length == 0)
            return fallback;
        try return value.to!ReleaseStatus;
        catch (Exception) return fallback;
    }

    static DeploymentStatus parseDeploymentStatus(
        string value,
        DeploymentStatus fallback = DeploymentStatus.scheduled
    ) {
        if (value.length == 0)
            return fallback;
        try return value.to!DeploymentStatus;
        catch (Exception) return fallback;
    }

    static EnvironmentType parseEnvironmentType(string value, EnvironmentType fallback = EnvironmentType.dev) {
        if (value.length == 0)
            return fallback;
        try return value.to!EnvironmentType;
        catch (Exception) return fallback;
    }

    static AlertSeverity parseAlertSeverity(string value, AlertSeverity fallback = AlertSeverity.warning) {
        if (value.length == 0)
            return fallback;
        try return value.to!AlertSeverity;
        catch (Exception) return fallback;
    }

    static AlertStatus parseAlertStatus(string value, AlertStatus fallback = AlertStatus.open) {
        if (value.length == 0)
            return fallback;
        try return value.to!AlertStatus;
        catch (Exception) return fallback;
    }

    static RiskLevel parseRiskLevel(string value, RiskLevel fallback = RiskLevel.moderate) {
        if (value.length == 0)
            return fallback;
        try return value.to!RiskLevel;
        catch (Exception) return fallback;
    }

    static bool canAdvance(SolutionLifecycleStage current, SolutionLifecycleStage next) {
        if (current == next)
            return true;

        final switch (current) {
            case SolutionLifecycleStage.explore:
                return next == SolutionLifecycleStage.design;
            case SolutionLifecycleStage.design:
                return next == SolutionLifecycleStage.build;
            case SolutionLifecycleStage.build:
                return next == SolutionLifecycleStage.test;
            case SolutionLifecycleStage.test:
                return next == SolutionLifecycleStage.deploy;
            case SolutionLifecycleStage.deploy:
                return next == SolutionLifecycleStage.run;
            case SolutionLifecycleStage.run:
                return next == SolutionLifecycleStage.retire;
            case SolutionLifecycleStage.retire:
                return false;
        }
    }

    static bool isOpenAlert(AlertStatus status) {
        return status == AlertStatus.open || status == AlertStatus.acknowledged;
    }

    static bool isBlockedTask(TaskStatus status) {
        return status == TaskStatus.blocked;
    }
}

version(unittest) {
    unittest {
        assert(AlmPolicy.parseLifecycleStage("design") == SolutionLifecycleStage.design);
        assert(AlmPolicy.canAdvance(SolutionLifecycleStage.explore, SolutionLifecycleStage.design));
        assert(!AlmPolicy.canAdvance(SolutionLifecycleStage.deploy, SolutionLifecycleStage.build));
        assert(AlmPolicy.isOpenAlert(AlertStatus.open));
    }
}
