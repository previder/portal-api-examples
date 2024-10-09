variable "portal_config_token" {
  description = "Previder API Token"
  type        = string
}

variable "portal_config_url" {
  description = "Previder API Base URL (optional)"
  type        = string
  nullable    = true
}

variable "portal_config_customer" {
  description = "Previder API Customer ID (optional)"
  type        = string
  nullable    = true
}

variable "virtual_network_enabled" {
  description = "Enable Virtual network"
  type        = bool
}

variable "virtual_network_name" {
  description = "Name of the network"
  type        = string
}

variable "virtual_network_type" {
  description = "Type (IAN, VLAN, SEGMENT, VLAN_TRUNK)"
  type        = string
}

variable "virtual_network_group" {
  description = "ID or name of the group this network is part of"
  type        = string
}


variable "virtual_firewall_enabled" {
  description = "Enable Virtual network"
  type        = bool
}

variable "virtual_firewall_name" {
  description = "Name of the network"
  type        = string
}

variable "virtual_firewall_type" {
  description = "Type (previder)"
  type        = string
}

/*variable "virtual_firewall_network_id" {
  description = "The ID of the virtual network to associate with the firewall"
  type        = string
}*/

variable "virtual_firewall_lan_address" {
  description = "LAN address for the firewall"
  type        = string
}

variable "virtual_firewall_dhcp_enabled" {
  description = "Specifies whether DHCP is enabled"
  type        = bool
}

variable "virtual_firewall_dhcp_range_start" {
  description = "Start of the DHCP range"
  type        = string
}

variable "virtual_firewall_dhcp_range_end" {
  description = "End of the DHCP range"
  type        = string
}

variable "virtual_firewall_dns_enabled" {
  description = "Specifies whether DNS is enabled"
  type        = bool
}

variable "virtual_firewall_nameservers" {
  description = "List of DNS nameservers"
  type = list(string)
}

variable "virtual_firewall_termination_protected" {
  description = "Specifies whether termination protection is enabled"
  type        = bool
}

variable "virtual_firewall_icmp_lan_enabled" {
  description = "Specifies whether ICMP is enabled on the LAN"
  type        = bool
}

variable "virtual_firewall_nat_rules" {
  description = "NAT rules for the firewall"
  type = map(object({
    port            = number
    source          = string
    protocol        = string
    active          = bool
    nat_destination = string
    nat_port        = number
  }))
}


variable "kubernetes_cluster_enabled" {
  description = "Enable Kubernetes Cluster"
  type        = bool
}

variable "kubernetes_cluster_name" {
  description = "Name of the cluster"
  type        = string
}

variable "kubernetes_cluster_cni" {
  description = "CNI to install"
  type        = string
}

variable "kubernetes_cluster_vips" {
  description = "VIPS as comma seperated list"
  type = list(string)
}

variable "kubernetes_cluster_version" {
  description = "Version of the cluster (only when auto update is disabled)"
  type        = string
}

variable "kubernetes_cluster_auto_update" {
  description = "Automatically get the newest Kubernetes version"
  type        = bool
}

variable "kubernetes_cluster_auto_scale_enabled" {
  description = "Install an cluster autoscaler"
  type        = bool
}

variable "kubernetes_cluster_minimal_nodes" {
  description = "Minimal nodes"
  type        = number
}

variable "kubernetes_cluster_maximal_nodes" {
  description = "Maximal nodes"
  type        = number
}

variable "kubernetes_cluster_control_plane_cpu_cores" {
  description = "Number of cpu cores per node"
  type        = number
}

variable "kubernetes_cluster_control_plane_memory_gb" {
  description = "Number of memory GB per node"
  type        = number
}

variable "kubernetes_cluster_control_plane_storage_gb" {
  description = "Storage capacity per node (minimum 25)"
  type        = number
}

variable "kubernetes_cluster_node_cpu_cores" {
  description = "Number of cpu cores per node"
  type        = number
}

variable "kubernetes_cluster_node_memory_gb" {
  description = "Number of memory GB per node"
  type        = number
}

variable "kubernetes_cluster_node_storage_gb" {
  description = "Storage capacity per node (minimum 25)"
  type        = number
}

variable "kubernetes_cluster_compute_cluster" {
  description = "Compute cluster"
  type        = string
}

variable "kubernetes_cluster_high_available_control_plane" {
  description = "Install 1 or 3 control planes"
  type        = bool
}

# STaaS environment
variable "staas_environment_enabled" {
  description = "Create a STaaS environment"
  type        = bool
}

variable "staas_environment_name" {
  description = "Name of the STaaS environment"
  type        = string
}

variable "staas_environment_type" {
  description = "Type of the STaaS environment"
  type        = string
}

variable "staas_environment_cluster_id" {
  description = "Cluster ID for the STaaS environment"
  type        = string
}

variable "staas_environment_windows" {
  description = "Boolean to specify if Windows is enabled"
  type        = bool
}

variable "staas_environment_volume_name" {
  description = "Volume name"
  type        = string
}

variable "staas_environment_volume_size_mb" {
  description = "Size in MB for the volume"
  type        = number
}

variable "staas_environment_volume_type" {
  description = "Volume type, NFS or ISCSI"
  type        = string
}
variable "staas_environment_volume_ip_range" {
  description = "IP CIDR for ReadOnly and ReadWrite"
  type        = string
}

variable "staas_environment_vip" {
  description = "VIP in CIDR format of the volume in the network"
  type        = string
}