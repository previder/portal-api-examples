resource "previder_virtual_network" "network" {
  count = var.virtual_network_enabled ? 1 : 0
  name  = var.virtual_network_name
  type  = var.virtual_network_type
  group = var.virtual_network_group
}

resource "previder_virtual_firewall" "firewall" {
  depends_on = [
    previder_virtual_network.network
  ]
  count                 = var.virtual_firewall_enabled ? 1 : 0
  name                  = var.virtual_firewall_name
  type                  = var.virtual_firewall_type
  network               = previder_virtual_network.network[0].id
  lan_address           = var.virtual_firewall_lan_address
  dhcp_enabled          = var.virtual_firewall_dhcp_enabled
  dhcp_range_start      = var.virtual_firewall_dhcp_range_start
  dhcp_range_end        = var.virtual_firewall_dhcp_range_end
  dns_enabled           = var.virtual_firewall_dns_enabled
  nameservers           = var.virtual_firewall_nameservers
  termination_protected = var.virtual_firewall_termination_protected
  icmp_lan_enabled      = var.virtual_firewall_icmp_lan_enabled
  nat_rules             = var.virtual_firewall_nat_rules
}

resource "previder_kubernetes_cluster" "cluster" {
  depends_on = [
    previder_virtual_firewall.firewall
  ]
  count                        = var.kubernetes_cluster_enabled ? 1 : 0
  name                         = var.kubernetes_cluster_name
  cni                          = var.kubernetes_cluster_cni
  network                      = previder_virtual_network.network[0].id
  vips                         = var.kubernetes_cluster_vips
  endpoints = [previder_virtual_firewall.firewall[0].wan_address[0]]
  version                      = var.kubernetes_cluster_version
  auto_update                  = var.kubernetes_cluster_auto_update
  auto_scale_enabled           = var.kubernetes_cluster_auto_scale_enabled
  minimal_nodes                = var.kubernetes_cluster_minimal_nodes
  control_plane_cpu_cores      = var.kubernetes_cluster_control_plane_cpu_cores
  control_plane_memory_gb      = var.kubernetes_cluster_control_plane_memory_gb
  control_plane_storage_gb     = var.kubernetes_cluster_control_plane_storage_gb
  node_cpu_cores               = var.kubernetes_cluster_node_cpu_cores
  node_memory_gb               = var.kubernetes_cluster_node_memory_gb
  node_storage_gb              = var.kubernetes_cluster_node_storage_gb
  compute_cluster              = var.kubernetes_cluster_compute_cluster
  high_available_control_plane = var.kubernetes_cluster_high_available_control_plane
}

resource previder_staas_environment "staas" {
  count = previder_virtual_network.network[0].type == "VLAN" && var.staas_environment_enabled ? 1 : 0
  name    = var.staas_environment_name
  type    = var.staas_environment_type
  cluster = var.staas_environment_cluster_id
  windows = var.staas_environment_windows
  volumes = {
    (var.staas_environment_volume_name) = {
      name    = var.staas_environment_volume_name
      size_mb = var.staas_environment_volume_size_mb
      type    = var.staas_environment_volume_type
      allowed_ips_ro = [var.staas_environment_volume_ip_range]
      allowed_ips_rw = [var.staas_environment_volume_ip_range]
    },
  }
  networks = {
    (previder_virtual_network.network[0].id) = {
      network_id = previder_virtual_network.network[0].id
      cidr       = var.staas_environment_vip
    },
  }
}