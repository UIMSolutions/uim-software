/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.sci.domain.services.resource_validator;

import uim.platform.sci;

mixin(ShowModule!());

@safe:

struct ResourceValidator {
    static bool isValidInstance(Instance i) {
        return i.name.length > 0 && i.flavorId.length > 0 && i.imageId.length > 0 && i.tenantId.length > 0;
    }

    static bool isValidVolume(Volume v) {
        return v.name.length > 0 && v.size.length > 0 && v.tenantId.length > 0;
    }

    static bool isValidNetwork(Network n) {
        return n.name.length > 0 && n.cidr.length > 0 && n.tenantId.length > 0;
    }

    static bool isValidSecurityGroup(SecurityGroup sg) {
        return sg.name.length > 0 && sg.tenantId.length > 0;
    }

    static bool isValidFloatingIp(FloatingIp fip) {
        return fip.name.length > 0 && fip.floatingIpAddress.length > 0 && fip.networkId.length > 0 && fip.tenantId.length > 0;
    }

    static bool isValidLoadBalancer(LoadBalancer lb) {
        return lb.name.length > 0 && lb.vipAddress.length > 0 && lb.tenantId.length > 0;
    }

    static bool isValidDnsZone(DnsZone dz) {
        return dz.name.length > 0 && dz.email.length > 0 && dz.tenantId.length > 0;
    }

    static bool isValidKeyPair(KeyPair kp) {
        return kp.name.length > 0 && kp.publicKey.length > 0 && kp.tenantId.length > 0;
    }
}
