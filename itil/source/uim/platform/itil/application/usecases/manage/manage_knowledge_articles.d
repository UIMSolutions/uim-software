/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.itil.application.usecases.manage.manage_knowledge_articles;

import uim.platform.itil;

mixin(ShowModule!());

@safe:

class ManageKnowledgeArticlesUseCase : UIMUseCase {
    private KnowledgeArticleRepository repo;

    this(KnowledgeArticleRepository repo) { this.repo = repo; }

    KnowledgeArticle* get_(KnowledgeArticleId id) { return repo.findById(id); }
    KnowledgeArticle[] list() { return repo.findAll(); }
    KnowledgeArticle[] listByTenant(TenantId tenantId) { return repo.findByTenant(tenantId); }
    KnowledgeArticle[] listByStatus(KnowledgeStatus status) { return repo.findByStatus(status); }
    KnowledgeArticle[] listByService(ITServiceId serviceId) { return repo.findByService(serviceId); }
    KnowledgeArticle[] listByAuthor(string author) { return repo.findByAuthor(author); }

    CommandResult create(KnowledgeArticleDTO dto) {
        KnowledgeArticle ka;
        ka.id = dto.id;
        ka.tenantId = dto.tenantId;
        ka.title = dto.title;
        ka.body_ = dto.body_;
        ka.category = dto.category;
        ka.serviceId = dto.serviceId;
        ka.author = dto.author;
        ka.reviewer = dto.reviewer;
        ka.publishedDate = dto.publishedDate;
        ka.createdBy = dto.createdBy;
        if (!ITILValidator.isValidKnowledgeArticle(ka))
            return CommandResult(false, "", "Invalid knowledge article data");
        repo.save(ka);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(KnowledgeArticleDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null) return CommandResult(false, "", "Knowledge article not found");
        if (dto.title.length > 0) existing.title = dto.title;
        if (dto.body_.length > 0) existing.body_ = dto.body_;
        if (dto.reviewer.length > 0) existing.reviewer = dto.reviewer;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(KnowledgeArticleId id) {
        auto existing = repo.findById(id);
        if (existing is null) return CommandResult(false, "", "Knowledge article not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
