/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.sci.application.usecases.manage.manage_key_pairs;

import uim.platform.sci;

mixin(ShowModule!());

@safe:

class ManageKeyPairsUseCase : UIMUseCase {
    private KeyPairRepository repo;

    this(KeyPairRepository repo) {
        this.repo = repo;
    }

    KeyPair* get_(KeyPairId id) {
        return repo.findById(id);
    }

    KeyPair[] list() {
        return repo.findAll();
    }

    KeyPair[] listByTenant(TenantId tenantId) {
        return repo.findByTenant(tenantId);
    }

    KeyPair[] listByType(KeyPairType keyPairType) {
        return repo.findByType(keyPairType);
    }

    KeyPair[] listByUser(UserId userId) {
        return repo.findByUser(userId);
    }

    CommandResult create(KeyPairDTO dto) {
        KeyPair kp;
        kp.id = dto.id;
        kp.tenantId = dto.tenantId;
        kp.name = dto.name;
        kp.description = dto.description;
        kp.publicKey = dto.publicKey;
        kp.fingerprint = dto.fingerprint;
        kp.userId = dto.userId;
        kp.createdBy = dto.createdBy;
        if (!ResourceValidator.isValidKeyPair(kp))
            return CommandResult(false, "", "Invalid key pair data");
        repo.save(kp);
        return CommandResult(true, dto.id, "");
    }

    CommandResult update(KeyPairDTO dto) {
        auto existing = repo.findById(dto.id);
        if (existing is null)
            return CommandResult(false, "", "Key pair not found");
        if (dto.name.length > 0) existing.name = dto.name;
        if (dto.description.length > 0) existing.description = dto.description;
        if (dto.modifiedBy.length > 0) existing.modifiedBy = dto.modifiedBy;
        repo.update(*existing);
        return CommandResult(true, dto.id, "");
    }

    CommandResult remove(KeyPairId id) {
        auto existing = repo.findById(id);
        if (existing is null)
            return CommandResult(false, "", "Key pair not found");
        repo.remove(id);
        return CommandResult(true, id, "");
    }
}
