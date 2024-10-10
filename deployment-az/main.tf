module "deployment" {
  source                  = "./infrastructure"
  virtual_network_enabled = var.previder_virtual_network_enabled
  virtual_network_name    = var.previder_virtual_network_name
  virtual_network_type    = var.previder_virtual_network_type
  virtual_network_group   = var.previder_virtual_network_group

  virtual_firewall_enabled               = var.previder_virtual_firewall_enabled
  virtual_firewall_name                  = var.previder_virtual_firewall_name
  virtual_firewall_type                  = var.previder_virtual_firewall_type
  virtual_firewall_lan_address           = var.previder_virtual_firewall_lan_address
  virtual_firewall_dhcp_enabled          = var.previder_virtual_firewall_dhcp_enabled
  virtual_firewall_dhcp_range_start      = var.previder_virtual_firewall_dhcp_range_start
  virtual_firewall_dhcp_range_end        = var.previder_virtual_firewall_dhcp_range_end
  virtual_firewall_dns_enabled           = var.previder_virtual_firewall_dns_enabled
  virtual_firewall_nameservers           = var.previder_virtual_firewall_nameservers
  virtual_firewall_termination_protected = var.previder_virtual_firewall_termination_protected
  virtual_firewall_icmp_lan_enabled      = var.previder_virtual_firewall_icmp_lan_enabled
  virtual_firewall_nat_rules             = var.previder_virtual_firewall_nat_rules

  kubernetes_cluster_enabled                      = var.previder_kubernetes_cluster_enabled
  kubernetes_cluster_auto_scale_enabled           = var.previder_kubernetes_cluster_auto_scale_enabled
  kubernetes_cluster_auto_update                  = var.previder_kubernetes_cluster_auto_update
  kubernetes_cluster_cni                          = var.previder_kubernetes_cluster_cni
  kubernetes_cluster_compute_cluster              = var.previder_kubernetes_cluster_compute_cluster
  kubernetes_cluster_control_plane_cpu_cores      = var.previder_kubernetes_cluster_control_plane_cpu_cores
  kubernetes_cluster_control_plane_memory_gb      = var.previder_kubernetes_cluster_control_plane_memory_gb
  kubernetes_cluster_control_plane_storage_gb     = var.previder_kubernetes_cluster_control_plane_storage_gb
  kubernetes_cluster_high_available_control_plane = var.previder_kubernetes_cluster_high_available_control_plane
  kubernetes_cluster_maximal_nodes                = var.previder_kubernetes_cluster_maximal_nodes
  kubernetes_cluster_minimal_nodes                = var.previder_kubernetes_cluster_minimal_nodes
  kubernetes_cluster_name                         = var.previder_kubernetes_cluster_name
  kubernetes_cluster_node_cpu_cores               = var.previder_kubernetes_cluster_node_cpu_cores
  kubernetes_cluster_node_memory_gb               = var.previder_kubernetes_cluster_node_memory_gb
  kubernetes_cluster_node_storage_gb              = var.previder_kubernetes_cluster_node_storage_gb
  kubernetes_cluster_version                      = var.previder_kubernetes_cluster_version
  kubernetes_cluster_vips                         = var.previder_kubernetes_cluster_vips

  staas_environment_enabled         = var.previder_staas_environment_enabled
  staas_environment_name            = var.previder_staas_environment_name
  staas_environment_type            = var.previder_staas_environment_type
  staas_environment_cluster_id      = var.previder_staas_environment_cluster_id
  staas_environment_windows         = var.previder_staas_environment_windows
  staas_environment_volume_name     = var.previder_staas_environment_volume_name
  staas_environment_volume_size_mb  = var.previder_staas_environment_volume_size_mb
  staas_environment_volume_type     = var.previder_staas_environment_volume_type
  staas_environment_volume_ip_range = var.previder_staas_environment_volume_ip_range
  staas_environment_vip             = var.previder_staas_environment_vip

  portal_config_url      = var.previder_portal_config_url
  portal_config_token    = var.previder_portal_config_token
  portal_config_customer = var.previder_portal_config_customer
}
