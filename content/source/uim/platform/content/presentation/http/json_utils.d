module uim.platform.content.presentation.http.json_utils;

import vibe.data.json : Json;
import uim.platform.content.domain.entities.content_repository : ContentRepository;
import uim.platform.content.domain.entities.folder : Folder;
import uim.platform.content.domain.entities.document : Document;
import uim.platform.content.domain.entities.document_version : DocumentVersion;

@safe:

Json repositoryToJson(ContentRepository value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["name"] = Json(value.name);
    j["description"] = Json(value.description);
    j["storageType"] = Json(value.storageType);
    j["basePath"] = Json(value.basePath);
    j["status"] = Json(value.status);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    j["createdAt"] = Json(value.createdAt);
    j["modifiedAt"] = Json(value.modifiedAt);
    return j;
}

Json folderToJson(Folder value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["repositoryId"] = Json(value.repositoryId);
    j["parentFolderId"] = Json(value.parentFolderId);
    j["name"] = Json(value.name);
    j["path"] = Json(value.path);
    j["description"] = Json(value.description);
    j["status"] = Json(value.status);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    j["createdAt"] = Json(value.createdAt);
    j["modifiedAt"] = Json(value.modifiedAt);
    return j;
}

Json documentToJson(Document value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["repositoryId"] = Json(value.repositoryId);
    j["folderId"] = Json(value.folderId);
    j["title"] = Json(value.title);
    j["documentNumber"] = Json(value.documentNumber);
    j["objectType"] = Json(value.objectType);
    j["mimeType"] = Json(value.mimeType);
    j["fileName"] = Json(value.fileName);
    j["fileSize"] = Json(value.fileSize);
    j["checksum"] = Json(value.checksum);
    j["storageUri"] = Json(value.storageUri);
    j["status"] = Json(value.status);
    j["classification"] = Json(value.classification);
    j["tags"] = Json(value.tags);
    j["createdBy"] = Json(value.createdBy);
    j["modifiedBy"] = Json(value.modifiedBy);
    j["createdAt"] = Json(value.createdAt);
    j["modifiedAt"] = Json(value.modifiedAt);
    return j;
}

Json documentVersionToJson(DocumentVersion value) {
    auto j = Json.emptyObject;
    j["id"] = Json(value.id);
    j["tenantId"] = Json(value.tenantId);
    j["documentId"] = Json(value.documentId);
    j["versionLabel"] = Json(value.versionLabel);
    j["fileName"] = Json(value.fileName);
    j["mimeType"] = Json(value.mimeType);
    j["fileSize"] = Json(value.fileSize);
    j["checksum"] = Json(value.checksum);
    j["storageUri"] = Json(value.storageUri);
    j["versionNote"] = Json(value.versionNote);
    j["createdBy"] = Json(value.createdBy);
    j["createdAt"] = Json(value.createdAt);
    return j;
}
