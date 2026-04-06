/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.sci.application.dto;

import uim.platform.sci;

mixin(ShowModule!());

@safe:

struct InstanceDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string flavorId;
    string flavorCategory;
    string imageId;
    string status;
    string powerState;
    string availabilityZone;
    string hostId;
    string keyPairId;
    string networkIds;
    string securityGroupIds;
    string serverGroupId;
    string userData;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct VolumeDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string size;
    string volumeType;
    string status;
    string instanceId;
    string availabilityZone;
    string snapshotId;
    string sourceVolumeId;
    bool encrypted;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct NetworkDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string networkType;
    string status;
    string cidr;
    string gateway;
    string dnsNameservers;
    bool isShared;
    bool isExternal;
    string availabilityZone;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct SecurityGroupDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string direction;
    string protocol;
    string portRangeMin;
    string portRangeMax;
    string remoteIpPrefix;
    string remoteGroupId;
    string etherType;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct FloatingIpDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string status;
    string floatingIpAddress;
    string fixedIpAddress;
    string networkId;
    string instanceId;
    string routerId;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct LoadBalancerDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string status;
    string algorithm;
    string vipAddress;
    string vipSubnetId;
    string protocol;
    string protocolPort;
    string healthMonitorUrl;
    string members;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct DnsZoneDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string status;
    string zoneType;
    string email;
    string ttl;
    string serial;
    string recordType;
    string recordName;
    string recordData;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}

struct KeyPairDTO {
    string id;
    string tenantId;
    string name;
    string description;
    string keyPairType;
    string publicKey;
    string fingerprint;
    string userId;
    string createdBy;
    string modifiedBy;
    string createdAt;
    string modifiedAt;
}
