/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.sci.presentation.http.json_utils;

import uim.platform.sci;

mixin(ShowModule!());

@safe:

Json instanceToJson(Instance e) {
    import std.conv : to;
    auto j = Json.emptyObject;
    j["id"] = Json(e.id);
    j["tenantId"] = Json(e.tenantId);
    j["name"] = Json(e.name);
    j["description"] = Json(e.description);
    j["flavorId"] = Json(e.flavorId);
    j["flavorCategory"] = Json(e.flavorCategory.to!string);
    j["imageId"] = Json(e.imageId);
    j["status"] = Json(e.status.to!string);
    j["powerState"] = Json(e.powerState.to!string);
    j["availabilityZone"] = Json(e.availabilityZone);
    j["hostId"] = Json(e.hostId);
    j["keyPairId"] = Json(e.keyPairId);
    j["networkIds"] = Json(e.networkIds);
    j["securityGroupIds"] = Json(e.securityGroupIds);
    j["serverGroupId"] = Json(e.serverGroupId);
    j["userData"] = Json(e.userData);
    j["createdBy"] = Json(e.createdBy);
    j["modifiedBy"] = Json(e.modifiedBy);
    j["createdAt"] = Json(e.createdAt);
    j["modifiedAt"] = Json(e.modifiedAt);
    return j;
}

Json volumeToJson(Volume e) {
    import std.conv : to;
    auto j = Json.emptyObject;
    j["id"] = Json(e.id);
    j["tenantId"] = Json(e.tenantId);
    j["name"] = Json(e.name);
    j["description"] = Json(e.description);
    j["size"] = Json(e.size);
    j["volumeType"] = Json(e.volumeType.to!string);
    j["status"] = Json(e.status.to!string);
    j["instanceId"] = Json(e.instanceId);
    j["availabilityZone"] = Json(e.availabilityZone);
    j["snapshotId"] = Json(e.snapshotId);
    j["sourceVolumeId"] = Json(e.sourceVolumeId);
    j["encrypted"] = Json(e.encrypted);
    j["createdBy"] = Json(e.createdBy);
    j["modifiedBy"] = Json(e.modifiedBy);
    j["createdAt"] = Json(e.createdAt);
    j["modifiedAt"] = Json(e.modifiedAt);
    return j;
}

Json networkToJson(Network e) {
    import std.conv : to;
    auto j = Json.emptyObject;
    j["id"] = Json(e.id);
    j["tenantId"] = Json(e.tenantId);
    j["name"] = Json(e.name);
    j["description"] = Json(e.description);
    j["networkType"] = Json(e.networkType.to!string);
    j["status"] = Json(e.status.to!string);
    j["cidr"] = Json(e.cidr);
    j["gateway"] = Json(e.gateway);
    j["dnsNameservers"] = Json(e.dnsNameservers);
    j["isShared"] = Json(e.isShared);
    j["isExternal"] = Json(e.isExternal);
    j["availabilityZone"] = Json(e.availabilityZone);
    j["createdBy"] = Json(e.createdBy);
    j["modifiedBy"] = Json(e.modifiedBy);
    j["createdAt"] = Json(e.createdAt);
    j["modifiedAt"] = Json(e.modifiedAt);
    return j;
}

Json securityGroupToJson(SecurityGroup e) {
    import std.conv : to;
    auto j = Json.emptyObject;
    j["id"] = Json(e.id);
    j["tenantId"] = Json(e.tenantId);
    j["name"] = Json(e.name);
    j["description"] = Json(e.description);
    j["direction"] = Json(e.direction.to!string);
    j["protocol"] = Json(e.protocol.to!string);
    j["portRangeMin"] = Json(e.portRangeMin);
    j["portRangeMax"] = Json(e.portRangeMax);
    j["remoteIpPrefix"] = Json(e.remoteIpPrefix);
    j["remoteGroupId"] = Json(e.remoteGroupId);
    j["etherType"] = Json(e.etherType);
    j["createdBy"] = Json(e.createdBy);
    j["modifiedBy"] = Json(e.modifiedBy);
    j["createdAt"] = Json(e.createdAt);
    j["modifiedAt"] = Json(e.modifiedAt);
    return j;
}

Json floatingIpToJson(FloatingIp e) {
    import std.conv : to;
    auto j = Json.emptyObject;
    j["id"] = Json(e.id);
    j["tenantId"] = Json(e.tenantId);
    j["name"] = Json(e.name);
    j["description"] = Json(e.description);
    j["status"] = Json(e.status.to!string);
    j["floatingIpAddress"] = Json(e.floatingIpAddress);
    j["fixedIpAddress"] = Json(e.fixedIpAddress);
    j["networkId"] = Json(e.networkId);
    j["instanceId"] = Json(e.instanceId);
    j["routerId"] = Json(e.routerId);
    j["createdBy"] = Json(e.createdBy);
    j["modifiedBy"] = Json(e.modifiedBy);
    j["createdAt"] = Json(e.createdAt);
    j["modifiedAt"] = Json(e.modifiedAt);
    return j;
}

Json loadBalancerToJson(LoadBalancer e) {
    import std.conv : to;
    auto j = Json.emptyObject;
    j["id"] = Json(e.id);
    j["tenantId"] = Json(e.tenantId);
    j["name"] = Json(e.name);
    j["description"] = Json(e.description);
    j["status"] = Json(e.status.to!string);
    j["algorithm"] = Json(e.algorithm.to!string);
    j["vipAddress"] = Json(e.vipAddress);
    j["vipSubnetId"] = Json(e.vipSubnetId);
    j["protocol"] = Json(e.protocol);
    j["protocolPort"] = Json(e.protocolPort);
    j["healthMonitorUrl"] = Json(e.healthMonitorUrl);
    j["members"] = Json(e.members);
    j["createdBy"] = Json(e.createdBy);
    j["modifiedBy"] = Json(e.modifiedBy);
    j["createdAt"] = Json(e.createdAt);
    j["modifiedAt"] = Json(e.modifiedAt);
    return j;
}

Json dnsZoneToJson(DnsZone e) {
    import std.conv : to;
    auto j = Json.emptyObject;
    j["id"] = Json(e.id);
    j["tenantId"] = Json(e.tenantId);
    j["name"] = Json(e.name);
    j["description"] = Json(e.description);
    j["status"] = Json(e.status.to!string);
    j["zoneType"] = Json(e.zoneType.to!string);
    j["email"] = Json(e.email);
    j["ttl"] = Json(e.ttl);
    j["serial"] = Json(e.serial);
    j["recordType"] = Json(e.recordType.to!string);
    j["recordName"] = Json(e.recordName);
    j["recordData"] = Json(e.recordData);
    j["createdBy"] = Json(e.createdBy);
    j["modifiedBy"] = Json(e.modifiedBy);
    j["createdAt"] = Json(e.createdAt);
    j["modifiedAt"] = Json(e.modifiedAt);
    return j;
}

Json keyPairToJson(KeyPair e) {
    import std.conv : to;
    auto j = Json.emptyObject;
    j["id"] = Json(e.id);
    j["tenantId"] = Json(e.tenantId);
    j["name"] = Json(e.name);
    j["description"] = Json(e.description);
    j["keyPairType"] = Json(e.keyPairType.to!string);
    j["publicKey"] = Json(e.publicKey);
    j["fingerprint"] = Json(e.fingerprint);
    j["userId"] = Json(e.userId);
    j["createdBy"] = Json(e.createdBy);
    j["modifiedBy"] = Json(e.modifiedBy);
    j["createdAt"] = Json(e.createdAt);
    j["modifiedAt"] = Json(e.modifiedAt);
    return j;
}
