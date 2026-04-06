/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.sci.domain.types;

import uim.platform.sci;

mixin(ShowModule!());

@safe:

// --- ID Aliases ---
alias InstanceId = string;
alias VolumeId = string;
alias NetworkId = string;
alias SecurityGroupId = string;
alias FloatingIpId = string;
alias LoadBalancerId = string;
alias DnsZoneId = string;
alias KeyPairId = string;
alias TenantId = string;
alias UserId = string;

// --- Enumerations ---

enum InstanceStatus {
    active,
    building,
    paused,
    suspended,
    shutoff,
    error,
    deleted,
    rescued
}

enum InstancePowerState {
    running,
    paused,
    shutdown,
    noState
}

enum FlavorCategory {
    general,
    compute,
    memory,
    storage,
    gpu,
    highPerformance
}

enum VolumeStatus {
    available,
    inUse,
    creating,
    deleting,
    error,
    extending,
    snapshotting
}

enum VolumeType {
    standard,
    ssd,
    highIops,
    archive
}

enum NetworkStatus {
    active,
    building,
    down,
    error
}

enum NetworkType {
    tenant,
    provider,
    external
}

enum SecurityGroupDirection {
    ingress,
    egress
}

enum SecurityGroupProtocol {
    tcp,
    udp,
    icmp,
    any
}

enum FloatingIpStatus {
    active,
    down,
    error
}

enum LoadBalancerStatus {
    active,
    pendingCreate,
    pendingUpdate,
    pendingDelete,
    error
}

enum LoadBalancerAlgorithm {
    roundRobin,
    leastConnections,
    sourceIp
}

enum DnsZoneStatus {
    active,
    pending,
    error
}

enum DnsZoneType {
    primary,
    secondary
}

enum DnsRecordType {
    a,
    aaaa,
    cname,
    mx,
    txt,
    ns,
    srv,
    ptr
}

enum KeyPairType {
    ssh,
    x509
}
