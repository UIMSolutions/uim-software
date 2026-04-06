/****************************************************************************************************************
* Copyright: (c) 2018-2026 Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.
* Authors: Ozan Nurettin Suel (aka UI-Manufaktur UG *R.I.P*)
*****************************************************************************************************************/
module uim.platform.sci.infrastructure.container;

import uim.platform.sci;

mixin(ShowModule!());

@safe:

struct Container {
    ManageInstancesUseCase manageInstancesUseCase;
    ManageVolumesUseCase manageVolumesUseCase;
    ManageNetworksUseCase manageNetworksUseCase;
    ManageSecurityGroupsUseCase manageSecurityGroupsUseCase;
    ManageFloatingIpsUseCase manageFloatingIpsUseCase;
    ManageLoadBalancersUseCase manageLoadBalancersUseCase;
    ManageDnsZonesUseCase manageDnsZonesUseCase;
    ManageKeyPairsUseCase manageKeyPairsUseCase;

    InstanceController instanceController;
    VolumeController volumeController;
    NetworkController networkController;
    SecurityGroupController securityGroupController;
    FloatingIpController floatingIpController;
    LoadBalancerController loadBalancerController;
    DnsZoneController dnsZoneController;
    KeyPairController keyPairController;
    HealthController healthController;
}

Container buildContainer(AppConfig config) {
    Container c;

    // Repositories
    auto instanceRepo = new MemoryInstanceRepository();
    auto volumeRepo = new MemoryVolumeRepository();
    auto networkRepo = new MemoryNetworkRepository();
    auto securityGroupRepo = new MemorySecurityGroupRepository();
    auto floatingIpRepo = new MemoryFloatingIpRepository();
    auto loadBalancerRepo = new MemoryLoadBalancerRepository();
    auto dnsZoneRepo = new MemoryDnsZoneRepository();
    auto keyPairRepo = new MemoryKeyPairRepository();

    // Use Cases
    c.manageInstancesUseCase = new ManageInstancesUseCase(instanceRepo);
    c.manageVolumesUseCase = new ManageVolumesUseCase(volumeRepo);
    c.manageNetworksUseCase = new ManageNetworksUseCase(networkRepo);
    c.manageSecurityGroupsUseCase = new ManageSecurityGroupsUseCase(securityGroupRepo);
    c.manageFloatingIpsUseCase = new ManageFloatingIpsUseCase(floatingIpRepo);
    c.manageLoadBalancersUseCase = new ManageLoadBalancersUseCase(loadBalancerRepo);
    c.manageDnsZonesUseCase = new ManageDnsZonesUseCase(dnsZoneRepo);
    c.manageKeyPairsUseCase = new ManageKeyPairsUseCase(keyPairRepo);

    // Controllers
    c.instanceController = new InstanceController(c.manageInstancesUseCase);
    c.volumeController = new VolumeController(c.manageVolumesUseCase);
    c.networkController = new NetworkController(c.manageNetworksUseCase);
    c.securityGroupController = new SecurityGroupController(c.manageSecurityGroupsUseCase);
    c.floatingIpController = new FloatingIpController(c.manageFloatingIpsUseCase);
    c.loadBalancerController = new LoadBalancerController(c.manageLoadBalancersUseCase);
    c.dnsZoneController = new DnsZoneController(c.manageDnsZonesUseCase);
    c.keyPairController = new KeyPairController(c.manageKeyPairsUseCase);
    c.healthController = new HealthController();

    return c;
}
