# Generic configuration
variable "previder_portal_config_token" {
  description = "Previder Provider Token Configuration"
  type        = string
  default     = ""
  sensitive   = true
}

variable "previder_portal_config_url" {
  description = "Previder Provider URL Configuration"
  type        = string
  default     = "https://portal.previder.nl/api"
}

variable "previder_portal_config_customer" {
  description = "Previder Provider sub customer id Configuration (optional)"
  type        = string
  default     = ""
}

# Virtual Network
variable "previder_virtual_network_enabled" {
  description = "Virtualnetwork enabled"
  type        = bool
  default     = true
}

variable "previder_virtual_network_name" {
  description = "Virtualnetwork name"
  type        = string
  default     = "virtual-network"
}

variable "previder_virtual_network_type" {
  description = "Virtualnetwork type [IAN, VLAN, VXLAN]"
  type        = string
  default     = "IAN"
  validation {
    error_message = "Network type must be one of IAN,VLAN,VXLAN"
    condition = contains(["IAN", "VLAN", "VXLAN"], var.previder_virtual_network_type)
  }
}

variable "previder_virtual_network_group" {
  description = "Virtualnetwork group"
  type        = string
  default     = ""
}

# Virtual Firewall
variable "previder_virtual_firewall_enabled" {
  description = "Virtual Firewall enabled"
  type        = bool
  default     = true
}

variable "previder_virtual_firewall_name" {
  description = "Virtual Firewall name"
  type        = string
  default     = "fw01"
}

variable "previder_virtual_firewall_type" {
  description = "Virtual Firewall type [previder]"
  type        = string
  default     = "previder"
  validation {
    error_message = "Virtual Firewall type must be one of previder"
    condition = contains(["previder"], var.previder_virtual_firewall_type)
  }
}

variable "previder_virtual_firewall_lan_address" {
  description = "LAN address for the firewall"
  type        = string
  default     = "10.10.10.1/24"
}

variable "previder_virtual_firewall_dhcp_enabled" {
  description = "Specifies whether DHCP is enabled"
  type        = bool
  default     = true
}

variable "previder_virtual_firewall_dhcp_range_start" {
  description = "Start of the DHCP range"
  type        = string
  default     = "10.10.10.10"
}

variable "previder_virtual_firewall_dhcp_range_end" {
  description = "End of the DHCP range"
  type        = string
  default     = "10.10.10.100"
}

variable "previder_virtual_firewall_dns_enabled" {
  description = "Specifies whether DNS is enabled"
  type        = bool
  default     = true
}

variable "previder_virtual_firewall_nameservers" {
  description = "List of DNS nameservers"
  type = list(string)
  default = ["80.65.96.50", "62.165.127.222"]
}

variable "previder_virtual_firewall_termination_protected" {
  description = "Specifies whether termination protection is enabled"
  type        = bool
  default     = true
}

variable "previder_virtual_firewall_icmp_lan_enabled" {
  description = "Specifies whether ICMP is enabled on the LAN"
  type        = bool
  default     = true
}

variable "previder_virtual_firewall_nat_rules" {
  description = "NAT rules for the firewall"
  type = map(object({
    port            = number
    source          = string
    protocol        = string
    active          = bool
    nat_destination = string
    nat_port        = number
  }))
  default = {}
}

# Kubernetes cluster
variable "previder_kubernetes_cluster_enabled" {
  description = "Whether the Kubernetes cluster is enabled"
  type        = bool
  default     = true
}

variable "previder_kubernetes_cluster_name" {
  description = "The name of the Kubernetes cluster"
  type        = string
  default     = "Cluster"
}

variable "previder_kubernetes_cluster_cni" {
  description = "Container Network Interface (CNI) used for the Kubernetes cluster"
  type        = string
  default     = "cilium"
}

variable "previder_kubernetes_cluster_vips" {
  description = "Virtual IPs (VIPs) for the Kubernetes cluster"
  type = list(string)
  default = ["10.10.10.2"]
}

variable "previder_kubernetes_cluster_version" {
  description = "Version of Kubernetes to deploy"
  type        = string
  default     = null
}

variable "previder_kubernetes_cluster_auto_update" {
  description = "Specifies whether auto-update is enabled for the Kubernetes cluster"
  type        = bool
  default     = true
}

variable "previder_kubernetes_cluster_auto_scale_enabled" {
  description = "Specifies whether auto-scaling is enabled for the Kubernetes cluster"
  type        = bool
  default     = false
}

variable "previder_kubernetes_cluster_minimal_nodes" {
  description = "The minimal number of nodes in the Kubernetes cluster"
  type        = number
  default     = 1
}


variable "previder_kubernetes_cluster_maximal_nodes" {
  description = "The maximal number of nodes in the Kubernetes cluster"
  type        = number
  default     = 1
}

variable "previder_kubernetes_cluster_control_plane_cpu_cores" {
  description = "Number of CPU cores for the control plane"
  type        = number
  default     = 2
}

variable "previder_kubernetes_cluster_control_plane_memory_gb" {
  description = "Amount of memory in GB for the control plane"
  type        = number
  default     = 4
}

variable "previder_kubernetes_cluster_control_plane_storage_gb" {
  description = "Amount of storage in GB for the control plane"
  type        = number
  default     = 50
}

variable "previder_kubernetes_cluster_node_cpu_cores" {
  description = "Number of CPU cores for each node"
  type        = number
  default     = 2
}

variable "previder_kubernetes_cluster_node_memory_gb" {
  description = "Amount of memory in GB for each node"
  type        = number
  default     = 4
}

variable "previder_kubernetes_cluster_node_storage_gb" {
  description = "Amount of storage in GB for each node"
  type        = number
  default     = 50
}

variable "previder_kubernetes_cluster_compute_cluster" {
  description = "Compute cluster ID or name for the Kubernetes cluster"
  type        = string
  default     = "express"
}

variable "previder_kubernetes_cluster_high_available_control_plane" {
  description = "Specifies if the control plane should be highly available"
  type        = bool
  default     = false
}


# STaaS environment
variable "previder_staas_environment_enabled" {
  description = "Create a STaaS environment, network type must be VLAN"
  type        = bool
  default     = true
}

variable "previder_staas_environment_name" {
  description = "Name of the STaaS environment"
  type        = string
  default     = "STaaS"
}

variable "previder_staas_environment_type" {
  description = "Type of the STaaS environment"
  type        = string
  default     = "NFS"
}

variable "previder_staas_environment_cluster_id" {
  description = "Cluster ID for the STaaS environment"
  type        = string
  default     = "5ff6d4cc02d0fc472c40bc17"
}

variable "previder_staas_environment_windows" {
  description = "Boolean to specify if Windows is enabled"
  type        = bool
  default     = true
}

variable "previder_staas_environment_volume_name" {
  description = "Volume name"
  type        = string
  default     = "KubernetesVolume"
}

variable "previder_staas_environment_volume_size_mb" {
  description = "Size in MB for the volume"
  type        = number
  default     = 10240
}

variable "previder_staas_environment_volume_type" {
  description = "Volume type, NFS or ISCSI"
  type        = string
  default     = "express"
}
variable "previder_staas_environment_volume_ip_range" {
  description = "IP CIDR for ReadOnly and ReadWrite"
  type        = string
  default     = "10.10.10.0/24"
}

variable "previder_staas_environment_vip" {
  description = "VIP of the volume in the network"
  type        = string
  default     = "10.10.10.3/24"
}